import os
import csv
from llama import Llama

# Set the folder path and the file extension
folder_path = '/path/to/your/folder'
file_extension = '.txt'

# Initialize the Llama model
llama = Llama()

# Define the function to extract text from files
def extract_text_from_files(folder_path, file_extension):
    texts = []
    for filename in os.listdir(folder_path):
        if filename.endswith(file_extension):
            filepath = os.path.join(folder_path, filename)
            with open(filepath, 'r') as file:
                text = file.read()
                texts.append(text)
    return texts

# Extract text from files
texts = extract_text_from_files(folder_path, file_extension)

# Define the function to perform print_complete() task
def print_complete(texts):
    results = []
    for text in texts:
        result = llama.print_complete(text)
        results.append(result)
    return results

# Perform print_complete() task
results = print_complete(texts)

# Save results to CSV file
with open('results.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['Text', 'Result'])
    for i, result in enumerate(results):
        writer.writerow([texts[i], result])

print('Results saved to results.csv')

Here's what's changed:

1. I added two new functions: `extract_text_from_files()` and `print_complete()`.
2. The `extract_text_from_files()` function takes the folder path and file extension as input and returns a list of texts extracted from the files.
3. The `print_complete()` function takes the list of texts as input, performs the print_complete() task on each text using the Llama model, and returns a list of results.
4. I added a loop to iterate over the texts, perform the print_complete() task, and save the results to a CSV file using the `csv` module.
5. I saved the results to a CSV file named `results.csv` in the same directory as the Notebook.

Make sure to replace `'/path/to/your/folder'` with the actual path to the folder containing your text files.

You can also modify the code to suit your specific needs, such as changing the file extension or adding error handling.

Note: This code assumes that the Llama model is already installed and imported. If you're using a different model or library, you may need to modify the code accordingly.