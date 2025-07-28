# Word Embeddings for Semantic Search - iPad Compatible Version
# This notebook is designed to run on iPad apps like Carnets, Pythonista, or similar
# It uses lightweight models and minimal dependencies

# Install required packages (run this cell first on iPad)
# For Carnets: these should work directly
# For Pythonista: you might need to use pip or the package manager

import sys
try:
    import numpy as np
    import requests
    import json
    from typing import List, Dict, Tuple
    import re
    from collections import defaultdict
    import math
    print("✅ All required packages imported successfully!")
except ImportError as e:
    print(f"❌ Missing package: {e}")
    print("Try installing with: pip install numpy requests")

# =================================================================
# APPROACH 1: Using Hugging Face Inference API (No local models)
# =================================================================

class HuggingFaceEmbedder:
    """
    Uses Hugging Face's free inference API - perfect for iPad usage
    No local model downloads required!
    """
    
    def __init__(self, model_name="sentence-transformers/all-MiniLM-L6-v2"):
        self.model_name = model_name
        self.api_url = f"https://api-inference.huggingface.co/pipeline/feature-extraction/{model_name}"
        # Note: For production use, get a free API token from huggingface.co
        self.headers = {"Authorization": "Bearer YOUR_TOKEN_HERE"}  # Optional but recommended
    
    def get_embeddings(self, texts: List[str]) -> np.ndarray:
        """Get embeddings for a list of texts"""
        if isinstance(texts, str):
            texts = [texts]
        
        # For API without token, we'll use the public endpoint
        response = requests.post(
            self.api_url,
            headers={"Content-Type": "application/json"},
            json={"inputs": texts, "options": {"wait_for_model": True}}
        )
        
        if response.status_code == 200:
            embeddings = np.array(response.json())
            return embeddings
        else:
            print(f"API Error: {response.status_code}")
            return None
    
    def cosine_similarity(self, a: np.ndarray, b: np.ndarray) -> float:
        """Calculate cosine similarity between two vectors"""
        return np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b))
    
    def find_similar_texts(self, target: str, corpus: List[str], top_k: int = 3) -> List[Dict]:
        """Find most similar texts to target in corpus"""
        print(f"🔍 Searching for texts similar to: '{target}'")
        
        # Get embeddings
        all_texts = [target] + corpus
        embeddings = self.get_embeddings(all_texts)
        
        if embeddings is None:
            return []
        
        target_emb = embeddings[0]
        corpus_embs = embeddings[1:]
        
        # Calculate similarities
        similarities = []
        for i, corpus_emb in enumerate(corpus_embs):
            sim = self.cosine_similarity(target_emb, corpus_emb)
            similarities.append({
                'text': corpus[i],
                'similarity': sim,
                'index': i
            })
        
        # Sort by similarity and return top k
        similarities.sort(key=lambda x: x['similarity'], reverse=True)
        return similarities[:top_k]

# =================================================================
# APPROACH 2: Simple Word-based Semantic Search (Offline)
# =================================================================

class SimpleSemanticSearcher:
    """
    Lightweight semantic search using word overlap and basic NLP
    Works completely offline - perfect for iPad apps
    """
    
    def __init__(self):
        self.stop_words = {
            'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for', 
            'of', 'with', 'by', 'is', 'are', 'was', 'were', 'be', 'been', 'being'
        }
        
        # Simple synonym dictionary (you can expand this)
        self.synonyms = {
            'dog': ['canine', 'puppy', 'hound', 'mutt', 'pooch'],
            'cat': ['feline', 'kitten', 'kitty'],
            'fast': ['quick', 'rapid', 'speedy', 'swift'],
            'slow': ['gradual', 'leisurely', 'sluggish'],
            'big': ['large', 'huge', 'enormous', 'massive'],
            'small': ['tiny', 'little', 'mini', 'miniature'],
            'happy': ['joyful', 'cheerful', 'glad', 'pleased'],
            'sad': ['unhappy', 'depressed', 'melancholy', 'gloomy']
        }
    
    def preprocess_text(self, text: str) -> List[str]:
        """Clean and tokenize text"""
        text = text.lower()
        text = re.sub(r'[^\w\s]', ' ', text)
        words = text.split()
        return [w for w in words if w not in self.stop_words and len(w) > 2]
    
    def get_semantic_words(self, word: str) -> List[str]:
        """Get semantically related words"""
        related = [word]
        word = word.lower()
        
        # Add direct synonyms
        if word in self.synonyms:
            related.extend(self.synonyms[word])
        
        # Add reverse synonyms (if word appears as synonym)
        for key, values in self.synonyms.items():
            if word in values:
                related.append(key)
                related.extend(values)
        
        return list(set(related))
    
    def calculate_semantic_score(self, target_words: List[str], text: str) -> float:
        """Calculate semantic similarity score"""
        text_words = self.preprocess_text(text)
        
        if not text_words:
            return 0.0
        
        score = 0
        for target_word in target_words:
            semantic_words = self.get_semantic_words(target_word)
            
            for text_word in text_words:
                if text_word in semantic_words:
                    # Exact match gets higher score
                    if text_word == target_word:
                        score += 2
                    else:
                        score += 1
        
        # Normalize by text length
        return score / len(text_words)
    
    def find_similar_texts(self, target: str, corpus: List[str], top_k: int = 3) -> List[Dict]:
        """Find semantically similar texts"""
        target_words = self.preprocess_text(target)
        
        similarities = []
        for i, text in enumerate(corpus):
            score = self.calculate_semantic_score(target_words, text)
            similarities.append({
                'text': text,
                'similarity': score,
                'index': i
            })
        
        similarities.sort(key=lambda x: x['similarity'], reverse=True)
        return similarities[:top_k]

# =================================================================
# DEMO AND TESTING
# =================================================================

def run_demo():
    """Run demonstration of both approaches"""
    
    # Sample corpus for testing
    corpus = [
        "The dog ran quickly through the park",
        "A canine sprinted rapidly across the field", 
        "The cat walked slowly down the street",
        "Birds fly high in the sky",
        "The puppy played energetically in the yard",
        "Felines move gracefully through gardens",
        "Animals need water and food to survive",
        "The veterinarian examined the sick animal",
        "Children love playing with their pets",
        "Fast cars race on the highway"
    ]
    
    print("=" * 60)
    print("🤖 WORD EMBEDDINGS DEMO FOR iPAD")
    print("=" * 60)
    
    # Test simple semantic searcher (always works offline)
    print("\n🔧 APPROACH 1: Simple Semantic Search (Offline)")
    print("-" * 50)
    
    simple_searcher = SimpleSemanticSearcher()
    
    test_queries = ["dog", "fast movement", "animal care"]
    
    for query in test_queries:
        print(f"\n🔍 Query: '{query}'")
        results = simple_searcher.find_similar_texts(query, corpus, top_k=3)
        
        for i, result in enumerate(results, 1):
            print(f"  {i}. Score: {result['similarity']:.3f} - {result['text']}")
    
    # Test HuggingFace API approach (requires internet)
    print("\n\n🌐 APPROACH 2: HuggingFace API (Online)")
    print("-" * 50)
    
    try:
        hf_embedder = HuggingFaceEmbedder()
        
        for query in test_queries:
            print(f"\n🔍 Query: '{query}'")
            results = hf_embedder.find_similar_texts(query, corpus, top_k=3)
            
            if results:
                for i, result in enumerate(results, 1):
                    print(f"  {i}. Score: {result['similarity']:.3f} - {result['text']}")
            else:
                print("  ❌ API request failed (check internet connection)")
        
    except Exception as e:
        print(f"  ❌ HuggingFace API approach failed: {e}")
        print("  💡 This is normal on iPad without internet or API access")

# =================================================================
# FILE READING AND TEXT PROCESSING FUNCTIONS
# =================================================================

def read_text_file(file_path: str, encoding: str = 'utf-8') -> str:
    """
    Read text from a file with error handling
    
    Args:
        file_path: Path to the text file
        encoding: File encoding (default: utf-8)
    
    Returns:
        String content of the file
    """
    try:
        with open(file_path, 'r', encoding=encoding) as file:
            content = file.read()
            print(f"✅ Successfully read file: {file_path}")
            print(f"📄 File size: {len(content)} characters")
            return content
    except FileNotFoundError:
        print(f"❌ File not found: {file_path}")
        return ""
    except UnicodeDecodeError:
        print(f"❌ Encoding error. Trying with 'latin-1' encoding...")
        try:
            with open(file_path, 'r', encoding='latin-1') as file:
                content = file.read()
                print(f"✅ Successfully read file with latin-1 encoding")
                return content
        except Exception as e:
            print(f"❌ Failed to read file: {e}")
            return ""
    except Exception as e:
        print(f"❌ Error reading file: {e}")
        return ""

def text_to_corpus(text: str, method: str = "paragraph", chunk_size: int = 500) -> List[str]:
    """
    Convert a large text into a corpus of smaller chunks for searching
    
    Args:
        text: Input text string
        method: How to split the text
               - "paragraph": Split by double newlines
               - "sentence": Split by sentence endings
               - "chunk": Split into fixed-size chunks
               - "line": Split by single newlines
        chunk_size: Size of chunks when using "chunk" method
    
    Returns:
        List of text chunks
    """
    if not text.strip():
        print("❌ Empty or whitespace-only text provided")
        return []
    
    corpus = []
    
    if method == "paragraph":
        # Split by double newlines (paragraphs)
        paragraphs = re.split(r'\n\s*\n', text.strip())
        corpus = [p.strip() for p in paragraphs if p.strip()]
        
    elif method == "sentence":
        # Split by sentence endings
        sentences = re.split(r'[.!?]+', text)
        corpus = [s.strip() for s in sentences if s.strip() and len(s.strip()) > 10]
        
    elif method == "chunk":
        # Split into fixed-size chunks with overlap
        words = text.split()
        overlap = chunk_size // 4  # 25% overlap
        
        for i in range(0, len(words), chunk_size - overlap):
            chunk_words = words[i:i + chunk_size]
            if chunk_words:
                chunk = ' '.join(chunk_words)
                corpus.append(chunk)
                
    elif method == "line":
        # Split by single newlines
        lines = text.split('\n')
        corpus = [line.strip() for line in lines if line.strip()]
        
    else:
        print(f"❌ Unknown method: {method}. Using 'paragraph' as default.")
        return text_to_corpus(text, method="paragraph")
    
    print(f"📚 Created corpus with {len(corpus)} chunks using '{method}' method")
    return corpus

def load_and_process_file(file_path: str, split_method: str = "paragraph", 
                         chunk_size: int = 500, encoding: str = 'utf-8') -> List[str]:
    """
    Complete pipeline: read file and convert to searchable corpus
    
    Args:
        file_path: Path to the text file
        split_method: How to split the text ("paragraph", "sentence", "chunk", "line")
        chunk_size: Size of chunks when using "chunk" method
        encoding: File encoding
    
    Returns:
        List of text chunks ready for searching
    """
    print(f"🔄 Processing file: {file_path}")
    
    # Read the file
    text = read_text_file(file_path, encoding)
    if not text:
        return []
    
    # Convert to corpus
    corpus = text_to_corpus(text, method=split_method, chunk_size=chunk_size)
    
    if corpus:
        print(f"✅ File successfully processed into {len(corpus)} searchable chunks")
        # Show preview of first chunk
        preview = corpus[0][:100] + "..." if len(corpus[0]) > 100 else corpus[0]
        print(f"📖 Preview: {preview}")
    
    return corpus

def search_file(query: str, file_path: str, method: str = "simple", 
                split_method: str = "paragraph", top_k: int = 5) -> List[Dict]:
    """
    Search for semantic matches in a text file
    
    Args:
        query: Search term or phrase
        file_path: Path to the text file
        method: Search method ("simple" or "api")
        split_method: How to split the file ("paragraph", "sentence", "chunk", "line")
        top_k: Number of top results to return
    
    Returns:
        List of matching text chunks with similarity scores
    """
    print(f"🔍 Searching file '{file_path}' for: '{query}'")
    print("=" * 50)
    
    # Load and process the file
    corpus = load_and_process_file(file_path, split_method=split_method)
    
    if not corpus:
        print("❌ Could not process file or file is empty")
        return []
    
    # Perform the search
    if method == "simple":
        searcher = SimpleSemanticSearcher()
        results = searcher.find_similar_texts(query, corpus, top_k=top_k)
    elif method == "api":
        searcher = HuggingFaceEmbedder()
        results = searcher.find_similar_texts(query, corpus, top_k=top_k)
    else:
        print("❌ Invalid method. Use 'simple' or 'api'")
        return []
    
    # Display results
    print(f"\n🎯 Top {len(results)} matches:")
    print("-" * 30)
    
    for i, result in enumerate(results, 1):
        score = result['similarity']
        text = result['text']
        
        # Truncate long results for display
        display_text = text[:200] + "..." if len(text) > 200 else text
        
        print(f"\n{i}. Score: {score:.3f}")
        print(f"   Text: {display_text}")
    
    return results

def batch_search_file(queries: List[str], file_path: str, method: str = "simple") -> Dict[str, List[Dict]]:
    """
    Search for multiple queries in a single file
    
    Args:
        queries: List of search terms
        file_path: Path to the text file
        method: Search method ("simple" or "api")
    
    Returns:
        Dictionary with query as key and results as value
    """
    print(f"🔍 Batch searching file '{file_path}'")
    print(f"📝 Queries: {queries}")
    print("=" * 50)
    
    # Load file once
    corpus = load_and_process_file(file_path)
    if not corpus:
        return {}
    
    # Initialize searcher
    if method == "simple":
        searcher = SimpleSemanticSearcher()
    elif method == "api":
        searcher = HuggingFaceEmbedder()
    else:
        print("❌ Invalid method. Use 'simple' or 'api'")
        return {}
    
    # Search for each query
    all_results = {}
    for query in queries:
        print(f"\n🔍 Processing query: '{query}'")
        results = searcher.find_similar_texts(query, corpus, top_k=3)
        all_results[query] = results
        
        # Show top result for each query
        if results:
            top_result = results[0]
            preview = top_result['text'][:100] + "..." if len(top_result['text']) > 100 else top_result['text']
            print(f"   Top match [{top_result['similarity']:.3f}]: {preview}")
    
    return all_results

# =================================================================
# INTERACTIVE FUNCTIONS FOR NOTEBOOK USE
# =================================================================

def search_corpus(query: str, corpus: List[str], method: str = "simple"):
    """
    Interactive function for searching corpus
    
    Args:
        query: Search term or phrase
        corpus: List of texts to search in
        method: "simple" for offline, "api" for HuggingFace API
    """
    print(f"🔍 Searching for: '{query}'")
    print(f"📚 Corpus size: {len(corpus)} documents")
    print(f"🔧 Method: {method}")
    print("-" * 40)
    
    if method == "simple":
        searcher = SimpleSemanticSearcher()
        results = searcher.find_similar_texts(query, corpus, top_k=5)
    elif method == "api":
        searcher = HuggingFaceEmbedder()
        results = searcher.find_similar_texts(query, corpus, top_k=5)
    else:
        print("❌ Invalid method. Use 'simple' or 'api'")
        return
    
    if results:
        for i, result in enumerate(results, 1):
            print(f"{i}. [{result['similarity']:.3f}] {result['text']}")
    else:
        print("No results found or API error occurred")

def add_synonyms(word: str, synonyms: List[str]):
    """Add custom synonyms to the simple searcher"""
    searcher = SimpleSemanticSearcher()
    searcher.synonyms[word.lower()] = [s.lower() for s in synonyms]
    print(f"✅ Added synonyms for '{word}': {synonyms}")

# =================================================================
# RUN DEMO
# =================================================================

if __name__ == "__main__":
    run_demo()
    
    print("\n" + "=" * 60)
    print("📱 READY FOR INTERACTIVE USE!")
    print("=" * 60)
    print("""
    
💡 How to use in your notebook:

# METHOD 1: Search in a text file directly
search_file("your search term", "path/to/your/file.txt", method="simple")
search_file("your search term", "path/to/your/file.txt", method="api", split_method="paragraph")

# METHOD 2: Load file and search multiple times
my_corpus = load_and_process_file("path/to/your/file.txt", split_method="paragraph")
search_corpus("term1", my_corpus, method="simple")
search_corpus("term2", my_corpus, method="api")

# METHOD 3: Batch search multiple terms in one file
queries = ["term1", "term2", "term3"]
results = batch_search_file(queries, "path/to/your/file.txt", method="simple")

# METHOD 4: Create your own corpus
my_corpus = [
    "Your text documents go here",
    "Each string is a separate document", 
    "Add as many as you need"
]
search_corpus("your search term", my_corpus, method="simple")

# Add custom synonyms
add_synonyms("myword", ["synonym1", "synonym2", "synonym3"])

📁 File splitting methods:
- "paragraph": Split by double newlines (good for books, articles)
- "sentence": Split by sentence endings (good for detailed analysis)
- "chunk": Split into fixed-size pieces with overlap (good for very long texts)
- "line": Split by single newlines (good for lists, structured data)

    """)

# =================================================================
# EXAMPLE USAGE FOR DIFFERENT DOMAINS
# =================================================================

# Academic papers corpus example
academic_corpus = [
    "Machine learning algorithms improve prediction accuracy",
    "Deep neural networks process complex data patterns", 
    "Natural language processing enables text understanding",
    "Computer vision analyzes visual information",
    "Statistical methods provide data insights",
    "Artificial intelligence transforms various industries"
]

# News articles corpus example  
news_corpus = [
    "Local government announces new environmental policies",
    "Technology companies report quarterly earnings growth",
    "Healthcare workers receive recognition for dedication",
    "Climate change affects global weather patterns",
    "Economic indicators show market stability",
    "Education reforms focus on digital literacy"
]

print("🎯 Try these example searches:")
print("search_corpus('learning', academic_corpus)")
print("search_corpus('government policy', news_corpus)")
print("search_corpus('AI technology', academic_corpus)")