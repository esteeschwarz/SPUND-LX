#!pip install transformers flask flask-cors torch
from flask import Flask, request, jsonify
from transformers import BartTokenizer, BartForConditionalGeneration
import torch

app = Flask(__name__)

# Load BART model (fine-tuned for coreference if available)
model_name = "facebook/bart-large"  # Replace with a fine-tuned model if possible
tokenizer = BartTokenizer.from_pretrained(model_name)
model = BartForConditionalGeneration.from_pretrained(model_name)

@app.route('/resolve', methods=['POST'])
def resolve_references():
    text = request.json.get('text', '')
    
    # Tokenize and generate (adjust for coreference resolution)
    inputs = tokenizer(text, return_tensors="pt", truncation=True, max_length=1024)
    summary_ids = model.generate(inputs["input_ids"], max_length=1024)
    resolved_text = tokenizer.batch_decode(summary_ids, skip_special_tokens=True)[0]
    
    return jsonify({"resolved_text": resolved_text})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
