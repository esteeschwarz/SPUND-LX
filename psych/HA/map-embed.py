#!/usr/bin/env python3
"""
Snippet to map embed_scores from t3_results_updated.csv to qltdf.csv
Maps based on url & lemma matching
"""

import pandas as pd
import numpy as np

# Set your base path
base_path = "~/boxHKW/21S/DH/local/SPUND/2025/stef_psych/"  # Adjust as needed

print("Loading dataframes...")

# Load the updated t3 results with embed scores
t3_updated = pd.read_csv(f"{base_path}t3_results_updated_os.csv")
print(f"✓ Loaded t3_updated: {t3_updated.shape}")

# Filter to only rows with embed_score (not NA)
t3_scores = t3_updated[t3_updated['embed_score'].notna()].copy()
print(f"✓ Found {len(t3_scores)} rows with embed_scores")

# Load the larger qltdf dataframe
qltdf = pd.read_csv(f"{base_path}eval_data_sub.csv")  # Adjust filename as needed
print(f"✓ Loaded qltdf: {qltdf.shape}")

# Ensure embed_score column exists in qltdf
if 'embed_score' not in qltdf.columns:
    qltdf['embed_score'] = np.nan
    print("✓ Created new embed_score column in qltdf (initialized with NaN)")
else:
    print(f"✓ embed_score column already exists in qltdf")
    print(f"  - Current non-NA values: {(~qltdf['embed_score'].isna()).sum()}")
    print(f"  - Current NA values: {qltdf['embed_score'].isna().sum()}")

# Ensure the column is float type for proper NaN handling
qltdf['embed_score'] = qltdf['embed_score'].astype('float64')
print("✓ Ensured embed_score column is float64 type")

print("Mapping scores from t3 to qltdf...")

# Create a mapping dictionary for fast lookup
# Key: (url, lemma), Value: embed_score
score_mapping = {}
for _, row in t3_scores.iterrows():
    key = (row['url'], row['lemma'])
    score_mapping[key] = row['embed_score']

print(f"✓ Created mapping with {len(score_mapping)} score entries")

# Map scores to qltdf
mapped_count = 0
for idx, row in qltdf.iterrows():
    key = (row['url'], row['lemma'])
    if key in score_mapping:
        qltdf.loc[idx, 'embed_score'] = score_mapping[key]
        mapped_count += 1

print(f"✓ Mapped {mapped_count} scores to qltdf")

# Save the updated qltdf
output_file = f"{base_path}qltdf_with_scores.csv"
qltdf.to_csv(output_file, index=False)

print(f"✓ Saved updated qltdf to: {output_file}")

# Summary statistics
print("\n=== SUMMARY ===")
print(f"qltdf total rows: {len(qltdf)}")
print(f"qltdf rows with embed_score: {(~qltdf['embed_score'].isna()).sum()}")
print(f"qltdf rows still missing embed_score: {qltdf['embed_score'].isna().sum()}")
print(f"Mapping success rate: {mapped_count / len(qltdf) * 100:.1f}%")

if mapped_count > 0:
    print(f"Mean embed_score: {qltdf['embed_score'].mean():.4f}")
    print(f"Score range: {qltdf['embed_score'].min():.4f} to {qltdf['embed_score'].max():.4f}")

print("Done!")
