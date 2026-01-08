%pip install pandas
import pandas as pd

# Load Parquet into DataFrame
df = pd.read_parquet("~/boxHKW/21S/DH/local/SPUND/2025/hux/pqdir/clip_results.parquet")

# Save as CSV (index=False avoids writing row indices)
df.to_csv("~/boxHKW/21S/DH/local/SPUND/2025/hux/clip_results.csv", index=False)
