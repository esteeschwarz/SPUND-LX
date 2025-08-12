#!/usr/bin/env python3
"""
Pure Python implementation of embed-run.R script
Converts R text:: package functionality to native Python using sentence-transformers
"""

import pandas as pd
import numpy as np
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import pickle
import os
from datetime import datetime
from tqdm import tqdm
import time
import random

class EmbeddingAnalyzer:
    """
    Class to handle text embedding and similarity analysis
    Replicates functionality from R text:: package
    """
    
    def __init__(self, model_name="sentence-transformers/all-MiniLM-L6-v2"):
        """Initialize with sentence transformer model"""
        print("Initializing sentence transformer model...")
        self.model = SentenceTransformer(model_name)
        print(f"Model {model_name} loaded successfully")
    
    def get_embed(self, corpus, normalize=True):
        """
        Equivalent to R's textEmbed() function
        Creates embeddings for corpus text
        """
        if isinstance(corpus, list):
            # Join corpus into single text
            corpus_text = ". ".join(str(x) for x in corpus if x is not None)
        else:
            corpus_text = str(corpus)
        
        # Generate embeddings
        embeddings = self.model.encode([corpus_text], normalize_embeddings=normalize)
        return embeddings
    
    def get_score(self, target_word, corpus_embeddings):
        """
        Equivalent to R's textSimilarity() function
        Calculate semantic similarity between target word and corpus
        """
        target_word = str(target_word)
        print(f"Processing word: -{target_word}-")
        
        # Write to log (equivalent to R's write() function)
        log_entry = f"{datetime.now()} || processing word: -{target_word}-\n"
        with open(self.log_file, 'a') as f:
            f.write(log_entry)
        
        try:
            # Create embedding for target word
            target_embedding = self.model.encode([target_word], normalize_embeddings=True)
            
            # Calculate cosine similarity
            if len(target_embedding) > 0 and len(corpus_embeddings) > 0:
                similarity = cosine_similarity(target_embedding, corpus_embeddings)[0][0]
                return similarity
            else:
                return np.nan
        except Exception as e:
            print(f"Error processing {target_word}: {e}")
            return np.nan
    
    def get_t_score(self, tokens, embeddings):
        """
        Process multiple tokens with progress bar (equivalent to pblapply)
        """
        t_scores = []
        for token in tqdm(tokens, desc="Processing tokens"):
            score = self.get_score(token, embeddings)
            t_scores.append(score)
        return t_scores
    
    def get_m_score(self, t_scores, tokens):
        """
        Create similarity dataframe and calculate mean
        """
        sim_df = pd.DataFrame({
            'token': tokens,
            'score': t_scores
        })
        # Sort by score descending
        sim_df = sim_df.sort_values('score', ascending=False).reset_index(drop=True)
        return sim_df
    
    def process_url_batch(self, url_data, lemma_data, url_list, range_indices, log_file):
        """
        Process a batch of URLs (main processing loop)
        """
        self.log_file = log_file
        start_time = datetime.now()
        
        with open(log_file, 'a') as f:
            f.write(f"{start_time} || Starting batch processing\n")
        
        results = {}
        
        for k, u_idx in enumerate(range_indices):
            print(f"\rProcessing {u_idx}, {k+1}/{len(range_indices)}")
            
            # Log progress
            with open(log_file, 'a') as f:
                f.write(f"{datetime.now()} ||\t url {u_idx}, {k+1}/{len(range_indices)} of {len(url_list)} urls todo\n")
            
            # Get URL and corresponding text data
            current_url = url_list[u_idx]
            
            # Get corpus for this URL (equivalent to t2.l[[u]])
            if u_idx < len(url_data):
                corpus = url_data[u_idx]
                
                # Get embeddings for corpus
                corpus_embeddings = self.get_embed(corpus)
                
                # Get lemmas for this URL
                url_lemmas = lemma_data[lemma_data['url'] == current_url]['lemma'].unique()
                
                # Calculate scores for all lemmas
                t_scores = self.get_t_score(url_lemmas, corpus_embeddings)
                sim_df = self.get_m_score(t_scores, url_lemmas)
                
                # Store results
                results[current_url] = sim_df
            
        end_time = datetime.now()
        elapsed = end_time - start_time
        
        with open(log_file, 'a') as f:
            f.write(f"{end_time} || finished after {elapsed} with {len(range_indices)} urls\n")
        
        return results

def main():
    """
    Main function replicating the R script logic
    """
    print("Loading datasets...")
    
    # Set up paths (equivalent to Sys.getenv("HKW_TOP"))
    base_path = os.path.expanduser("/project/workspace/")  # Adjust as needed
    
    # Load data
    try:
        # Load equivalent of eval-012_url-text.RData -> t2.l (URL text data)
        with open(f"{base_path}url_text_data.pkl", 'rb') as f:
            t2_l = pickle.load(f)
        print("✓ URL text data (t2_l) loaded successfully")
        
        # Load t3 as CSV (this is your results dataframe with lemma, url, freq, embed_score columns)
        t3 = pd.read_csv(f"{base_path}embed-0.csv")  # or whatever you named your t3 CSV export
        print("✓ Results dataframe (t3) loaded successfully from CSV")
        
        # Ensure embed_score column exists and has proper NA handling
        if 'embed_score' not in t3.columns:
            t3['embed_score'] = np.nan
            print("Added embed_score column to t3")
        
        print(f"t3 shape: {t3.shape}")
        print(f"t3 columns: {list(t3.columns)}")
        
    except FileNotFoundError as e:
        print(f"Data files not found: {e}")
        print("Please make sure you have:")
        print("1. url_text_data.pkl (from R: py_save_object(t2.l, 'url_text_data.pkl'))")
        print("2. t3_results.csv (from R: write.csv(t3, 't3_results.csv', row.names=FALSE))")
        return
    
    # Initialize text analyzer
    analyzer = EmbeddingAnalyzer()
    
    # Get unique URLs
    url_u = t3['url'].unique()
    
    # Apply numpy compatibility fix
    if not hasattr(np, '_core'):
        import numpy.core as _core
        np._core = _core

    # Load existing results if available
    results_file = f"{base_path}embed-0.pkl"
    if os.path.exists(results_file):
        try:
            with open(results_file, 'rb') as f:
                existing_results = pickle.load(f)
            print("Loaded existing results")
        except ModuleNotFoundError as e:
            if 'numpy._core' in str(e):
                print("NumPy compatibility issue - trying fallback loading")
                try:
                    with open(results_file, 'rb') as f:
                        existing_results = pickle.load(f, fix_imports=True, encoding='latin1')
                    print("Loaded existing results with fallback method")
                except:
                    print("Could not load existing results - starting fresh")
                    existing_results = {}
            else:
                raise e
        # Update t3 with existing scores (implement loading logic as needed)
    
    # Find URLs that still need processing
    missing_mask = t3['embed_score'].isna()
    url_n_done = t3.loc[missing_mask, 'url'].unique()
    
    print(f"Total URLs: {len(url_u)}")
    print(f"URLs still to process: {len(url_n_done)}")
    
    # Set up processing parameters
    log_file = os.path.expanduser("/project/workspace/embed-log.txt")
    os.makedirs(os.path.dirname(log_file), exist_ok=True)
    
    # Sample random subset for processing (equivalent to sample())
    rnd = 5
    n = 5
    # if len(url_n_done) > rnd:
    #     range_u = random.sample(range(len(url_n_done)), rnd)
   # else:
    range_u = list(range(len(url_n_done)))
    
    #range_u = list(range(0, n))

    # Process URLs
    try:
        results = analyzer.process_url_batch(
            url_data=t2_l,
            lemma_data=t3,
            url_list=url_n_done,
            range_indices=range_u,
            log_file=log_file
        )
        
        # Update t3 with results
        for url, sim_df in results.items():
            for _, row in sim_df.iterrows():
                mask = (t3['url'] == url) & (t3['lemma'] == row['token'])
                t3.loc[mask, 'embed_score'] = row['score']
        
        # Save results
        output_csv = f"{base_path}t3_results_updated.csv"
        t3.to_csv(output_csv, index=False)
        print(f"Processing completed successfully!")
        print(f"Updated results saved to: {output_csv}")
        
        # Show summary statistics
        print(f"\nFinal summary:")
        print(f"Total rows: {len(t3)}")
        print(f"Rows with embed_score: {(~t3['embed_score'].isna()).sum()}")
        print(f"Rows still missing embed_score: {t3['embed_score'].isna().sum()}")
        print(f"Mean embed_score: {t3['embed_score'].mean():.4f}")
        print(f"Score range: {t3['embed_score'].min():.4f} to {t3['embed_score'].max():.4f}")
        
    except Exception as e:
        print(f"Error during processing: {e}")
        # Save partial results
        t3.to_csv(f"{base_path}embed_results_partial.csv", index=False)

if __name__ == "__main__":
    main()

# Additional utility functions for data conversion

def convert_r_data():
    """
    Utility function to help convert R data files to Python format
    Run this in R first, then use the outputs in Python:
    
    # R code to export data:
    library(reticulate)
    
    # Save as RDS (can be read by pandas via pyreadr)
    saveRDS(t2.l, "url_text_data.rds")
    saveRDS(qltdf, "eval_data.rds") 
    
    # Or export as CSV
    write.csv(qltdf, "eval_data.csv", row.names=FALSE)
    
    # For t2.l (list), you might need to convert to JSON:
    library(jsonlite)
    write_json(t2.l, "url_text_data.json")
    """
    try:
        import pyreadr
        
        # Read RDS files
        result = pyreadr.read_r('eval_data.rds')
        qltdf = result[None]  # RDS files return dict with None key for single objects
        
        # For list data like t2.l, you might need JSON approach
        import json
        with open('url_text_data.json', 'r') as f:
            t2_l = json.load(f)
            
        return qltdf, t2_l
    
    except ImportError:
        print("pyreadr not available. Please install with: pip install pyreadr")
        print("Or convert data manually using R export functions shown above")
        return None, None

# Example usage and setup instructions
# print("""
# SETUP INSTRUCTIONS:

# 1. Install required packages:
#    pip install sentence-transformers pandas numpy scikit-learn tqdm

# 2. Convert R data files to Python format using one of these methods:

#    Method A - Using pyreadr (recommended):
#    - Install: pip install pyreadr
#    - Run the convert_r_data() function
   
#    Method B - Export from R:
#    In R, run:
#    library(jsonlite)
#    write.csv(qltdf, "eval_data.csv", row.names=FALSE)
#    write_json(t2.l, "url_text_data.json")
   
# 3. Adjust the base_path in main() to point to your data directory

# 4. Run the script: python embedding_analysis.py

# The script replicates your R workflow using:
# - sentence-transformers instead of R text::textEmbed()
# - sklearn cosine_similarity instead of R text::textSimilarity()  
# - pandas DataFrames instead of R data.frames
# - tqdm progress bars instead of R pbapply
# """)
