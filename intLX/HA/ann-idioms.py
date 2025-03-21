import sys

# Print the path of the currently running Python interpreter
print("Path of the Python interpreter:", sys.executable)

#################################
from datasets import load_dataset

# Load the dataset
dataset = load_dataset("davidstap/IdiomsInCtx-MT","de-en")

# Inspect the dataset
print(dataset["test"]["de"][0])  # View the first example


