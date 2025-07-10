import sys
#!{sys.executable} -m pip install groq
#!pip install groq
#import os
#import csv
#from llama import Llama
import os
from typing import Dict, List
from groq import Groq
import csv
# Get a free API key from https://console.groq.com/keys

credit_path = '/Users/guhl/boxHKW/21S/DH/local/R/cred_gener.csv'
q = 'groq'
api_key = None
with open(credit_path, 'r') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        if row['q'] == q:
            api_key = row['key']
            break

if api_key is None:
    raise ValueError(f"key not found for q='{q}'")

# Insert the extracted API key into the environment variable
os.environ["GROQ_API_KEY"] = api_key

LLAMA3_405B_INSTRUCT = "llama-3.1-405b-reasoning" # Note: Groq currently only gives access here to paying customers for 405B model
LLAMA3_70B_INSTRUCT = "llama-3.3-70b-versatile"
#LLAMA3_70B_INSTRUCT = "llama-3.1-70b"
#LLAMA3_70B_INSTRUCT = "llama3"
LLAMA3_8B_INSTRUCT = "llama3.1-8b-instant"
DEFAULT_MODEL = LLAMA3_70B_INSTRUCT
client = Groq()
def assistant(content: str):
    return { "role": "assistant", "content": content }
def user(content: str):
    return { "role": "user", "content": content }
def chat_completion(
    messages: List[Dict],
    model = DEFAULT_MODEL,
    temperature: float = 0.6,
    top_p: float = 0.9,
) -> str:
    response = client.chat.completions.create(
        messages=messages,
        model=model,
        temperature=temperature,
        top_p=top_p,
    )
    return response.choices[0].message.content
        
def completion(
    prompt: str,
    model: str = DEFAULT_MODEL,
    temperature: float = 0.6,
    top_p: float = 0.9,
) -> str:
    return chat_completion(
        [user(prompt)],
        model=model,
        temperature=temperature,
        top_p=top_p,
    )
def complete_and_print(prompt: str, model: str = DEFAULT_MODEL):
    print(f'==============\n{prompt}\n==============')
    response = completion(prompt, model)
    print(response, end='\n\n')
    return response
complete_and_print("The typical color of the sky is: ")
#import os
#import csv
# Set the folder path and the file extension
csv_file_path = '~/boxHKW/21S/DH/local/SPUND/intLX/data/reddit.com.df.cpt.15102.csv'
csv_file_path = '/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/data/reddit.com.df.cpt.15102.csv'
# 15285.xdinge
csv_file_path = '/Users/guhl/Documents/GitHub/SPUND-LX/szondi/dinge/llma-nounsdf.csv'
column_name = 'comment'
column_name = 'nouns'
#folder_path = 'texts/'
#file_extension = '.txt'
prompt = '{prompt: annotate text for figurative language elements where all occurences of figurative language are tagged like <idiom type="?1">?2</idiom>, where ?1 = of type of array["metaphor","idiom","metonyme","comparison"] and ?2 = the figurative element. limit the output to the tagged input text without further introduction or information provided or repeating of the prompt.} text: '
prompt = '{prompt: find all expressions in the text which refer to natural minerals and output a list of them without any annotation or extra information, just a commaseparated list of the natural mineral nouns in the text.} text: '
# Initialize the Llama model
#llama = Llama()
# Define the function to extract text from files
def extract_text_from_files_txt(folder_path, file_extension):
    texts = []
    for filename in os.listdir(folder_path):
        if filename.endswith(file_extension):
            filepath = os.path.join(folder_path, filename)
            with open(filepath, 'r') as file:
                text = file.read()
                text_with_prompt = f"{prompt} {text}"
                texts.append(text_with_prompt)
    return texts
# Define the function to extract text from files
def extract_text_from_files_dep(folder_path, file_extension):
    texts = []
    filenames = []
    for filename in os.listdir(folder_path):
        if filename.endswith(file_extension):
            filepath = os.path.join(folder_path, filename)
            with open(filepath, 'r') as file:
                text = file.read()
                text_with_prompt = f"{prompt} {text}"
                texts.append(text_with_prompt)
                filenames.append(filename)
    return texts, filenames
# Define the function to extract text from a CSV file column
# def extract_text_from_csv(csv_file_path, column_name, prompt):
#     texts = []
#     row_numbers = []
#     with open(csv_file_path, 'r') as csvfile:
#         reader = csv.DictReader(csvfile)
#         for row_number, row in enumerate(reader, start=1):
#         #for row in enumerate(reader, start=1):
#             #if start_row <= row_number <= end_row:
#                 text = row[column_name]
#                 text_with_prompt = f"{prompt} {text}"
#                 texts.append(text_with_prompt)
#                 #row_numbers.append(row_number)
#     return texts
# Define the function to extract text from a CSV file column
def extract_text_from_csv(csv_file_path, column_name, prompt):
    texts = []
    filenames = []
    with open(csv_file_path, 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            text = row[column_name]
            text_with_prompt = f"{prompt} {text}"
            texts.append(text_with_prompt)
            #filenames.append(row['Filename'])  # Assuming there's a 'Filename' column
    return texts#, filenames
# Extract text from the CSV file within the specified range of row numbers
start_row = 1
end_row = 1
#texts, row_numbers = extract_text_from_csv(csv_file_path, column_name, prompt, start_row, end_row)
texts = extract_text_from_csv(csv_file_path, column_name, prompt)
print(texts[0])
# Extract text from files
#texts = extract_text_from_files(folder_path, file_extension)
#texts, filenames = extract_text_from_files(folder_path, file_extension)
# # Define the function to perform print_complete() task
# def print_complete(texts):
#     results = []
#     for text in texts:
# #        result = llama.print_complete(text)
#         result = complete_and_print(text)
#         results.append(result)
#         print(result)
#     return results
# # Perform print_complete() task
# results = print_complete(texts)
# 1:20 > 25s
# Define the function to perform print_complete() task within a specified range of row numbers
def print_complete(texts, start_row, end_row):
    results = []
    #selected_row_numbers = []
    start_index = start_row -1
    end_index = end_row
    for text in texts[start_index:end_index]:
        #if start_row <= row_number <= end_row:
            # result = llama.print_complete(text)
            result = complete_and_print(text)  # Assuming complete_and_print is defined
            results.append(result)
            #selected_row_numbers.append(row_number)
            print(result)
    return results#, selected_row_numbers
# Specify the range of row numbers to process
start_row = 1
end_row = 1
# Perform print_complete() task within the specified range of row numbers
results = print_complete(texts, start_row, end_row)
# 1:10 > 5.5s
# 1:100 > 4.13m
print(results)
#results, selected_row_numbers = print_complete(texts, 1, 10)
#print(results[1:10])
#print(texts[1])
#result = complete_and_print(texts[1])  # Assuming complete_and_print is defined
#print(result)
for result in results:
        print(result)
# Save results to a new CSV file with the original row number and the annotated text
# output_csv_file_path = '/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/HA/data/reddit_annotated_results.csv'
# with open(output_csv_file_path, 'w', newline='') as csvfile:
#     writer = csv.writer(csvfile)
#     writer.writerow([ 'comment_annotated'])
#     for result in results:
#         writer.writerow(result)
# print(f'Results saved to {output_csv_file_path}')
output_filepath = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/HA/data/reddit_annotated_results.xml"
# Save results to a line text file
output_filepath = "/Users/guhl/Documents/GitHub/SPUND-LX/szondi/dinge/cal-minerals_llma.txt"
with open(output_filepath, 'w') as file:
    for result in results:
        file.write(result + '\n')
# Save results to CSV file
# with open('results.csv', 'w', newline='') as csvfile:
#     writer = csv.writer(csvfile)
#     writer.writerow(['Text', 'Result'])
#     for i, result in enumerate(results):
#         writer.writerow([texts[i], result])
# print('Results saved to results.csv')
# Save each result to a separate text file
# output_folder = 'results/'
# os.makedirs(output_folder, exist_ok=True)
# for i, result in enumerate(results):
#     output_filepath = os.path.join(output_folder, f"result_{filenames[i]}")
#     with open(output_filepath, 'w') as file:
#         file.write(result)
# print('Results saved to individual text files in the results/ folder')
print(results)
#complete_and_print("which model version are you?")
# def print_tuned_completion(temperature: float, top_p: float):
#     response = completion("Write a sonnet about frogs", temperature=temperature, top_p=top_p)
#     response = completion('Write a sonnet about frogs and tag all elements of figurative language with <idiom type="?1">?2</idiom>, where ?1 = of array["metaphor","idiom","metonyme","comparison"] and ?2 = the figurative element', temperature=temperature, top_p=top_p)
#     print(f'[temperature: {temperature} | top_p: {top_p}]\n{response.strip()}\n')
# print_tuned_completion(0.01, 0.01)
# print_tuned_completion(0.01, 0.01)
# # These two generations are highly likely to be the same
# print_tuned_completion(1.0, 1.0)
# print_tuned_completion(1.0, 1.0)
# # These two generations are highly likely to be different
# complete_and_print(prompt="Describe quantum physics in one short sentence of no more than 12 words")
# # Returns a succinct explanation of quantum physics that mentions particles and states existing simultaneously.
# complete_and_print("Explain the latest advances in large language models to me.")
# # More likely to cite sources from 2017
# complete_and_print("Explain the latest advances in large language models to me. Always cite your sources. Never cite sources older than 2020.")
# # Gives more specific advances and only cites sources from 2020
# complete_and_print("find and summarize 3 relevant academic papers not older than 2020 dealing with figurative language in internet speech corpora. cite paper and provide links to corresponding corpora. possible output in markdown.")
# complete_and_print("Text: This was the best movie I've ever seen! \n The sentiment of the text is: ")
# # Returns positive sentiment
# complete_and_print("Text: The director was trying too hard. \n The sentiment of the text is: ")
# # Returns negative sentiment
# def sentiment(text):
#     response = chat_completion(messages=[
#         user("You are a sentiment classifier. For each message, give the percentage of positive/netural/negative."),
#         user("I liked it"),
#         assistant("70% positive 30% neutral 0% negative"),
#         user("It could be better"),
#         assistant("0% positive 50% neutral 50% negative"),
#         user("It's fine"),
#         assistant("25% positive 50% neutral 25% negative"),
#         user(text),
#     ])
#     return response
# def print_sentiment(text):
#     print(f'INPUT: {text}')
#     print(sentiment(text))
# print_sentiment("I thought it was okay")
# # More likely to return a balanced mix of positive, neutral, and negative
# print_sentiment("I loved it!")
# # More likely to return 100% positive
# print_sentiment("Terrible service 0/10")
# # More likely to return 100% negative
# complete_and_print("Explain the pros and cons of using PyTorch.")
# # More likely to explain the pros and cons of PyTorch covers general areas like documentation, the PyTorch community, and mentions a steep learning curve
# complete_and_print("Your role is a machine learning expert who gives highly technical advice to senior engineers who work with complicated datasets. Explain the pros and cons of using PyTorch.")
# # Often results in more technical benefits and drawbacks that provide more technical details on how model layers
# complete_and_print('your role is tutor in a linguistics class who gives technical advice (a workflow, output as jupyter notebook, on how to modify this notebook: <https://github.com/meta-llama/llama-cookbook/blob/main/getting-started/Prompt_Engineering_with_Llama.ipynb>) to students helping them to use it to 1. annotate a corpus of german language textfiles (filesystem upload)for idiomatic expressions, 2. save the results to .xml files (filesystem) where all 3. elements of figurative language are tagged like <idiom type="?1">?2</idiom>, where ?1 = of array["metaphor","idiom","metonyme","comparison"] and ?2 = the figurative element')
# complete_and_print("Explain the pros and cons of using PyTorch.")
# # More likely to explain the pros and cons of PyTorch covers general areas like documentation, the PyTorch community, and mentions a steep learning curve
# complete_and_print("Your role is a machine learning expert who gives highly technical advice to senior engineers who work with complicated datasets. Explain the pros and cons of using PyTorch.")
# # Often results in more technical benefits and drawbacks that provide more technical details on how model layers
# prompt = "Who lived longer, Mozart or Elvis?"
# complete_and_print(prompt)
# # Llama 2 would often give the incorrect answer of "Mozart"
# complete_and_print(f"{prompt} Let's think through this carefully, step by step.")
# # Gives the correct answer "Elvis"
# import re
# from statistics import mode
# def gen_answer():
#     response = completion(
#         "John found that the average of 15 numbers is 40."
#         "If 10 is added to each number then the mean of the numbers is?"
#         "Report the answer surrounded by backticks (example: `123`)",
#     )
#     match = re.search(r'`(\d+)`', response)
#     if match is None:
#         return None
#     return match.group(1)
# answers = [gen_answer() for i in range(5)]
# print(
#     f"Answers: {answers}\n",
#     f"Final answer: {mode(answers)}",
#     )
# # Sample runs of Llama-3-70B (all correct):
# # ['60', '50', '50', '50', '50'] -> 50
# # ['50', '50', '50', '60', '50'] -> 50
# # ['50', '50', '60', '50', '50'] -> 50
# complete_and_print("What is the capital of the California?")
# # Gives the correct answer "Sacramento"
# complete_and_print("What was the temperature in Menlo Park on December 12th, 2023?")
# # "I'm just an AI, I don't have access to real-time weather data or historical weather records."
# complete_and_print("What time is my dinner reservation on Saturday and what should I wear?")
# # "I'm not able to access your personal information [..] I can provide some general guidance"
# MENLO_PARK_TEMPS = {
#     "2023-12-11": "52 degrees Fahrenheit",
#     "2023-12-12": "51 degrees Fahrenheit",
#     "2023-12-13": "51 degrees Fahrenheit",
# }
# def prompt_with_rag(retrived_info, question):
#     complete_and_print(
#         f"Given the following information: '{retrived_info}', respond to: '{question}'"
#     )
# def ask_for_temperature(day):
#     temp_on_day = MENLO_PARK_TEMPS.get(day) or "unknown temperature"
#     prompt_with_rag(
#         f"The temperature in Menlo Park was {temp_on_day} on {day}'",  # Retrieved fact
#         f"What is the temperature in Menlo Park on {day}?",  # User question
#     )
# ask_for_temperature("2023-12-12")
# # "Sure! The temperature in Menlo Park on 2023-12-12 was 51 degrees Fahrenheit."
# ask_for_temperature("2023-07-18")
# # "I'm not able to provide the temperature in Menlo Park on 2023-07-18 as the information provided states that the temperature was unknown."
# complete_and_print("""
# Calculate the answer to the following math problem:
# ((-5 + 93 * 4 - 0) * (4^4 + -7 + 0 * 5))
# """)
# # Gives incorrect answers like 92448, 92648, 95463
# complete_and_print(
#     """
#     # Python code to calculate: ((-5 + 93 * 4 - 0) * (4^4 + -7 + 0 * 5))
#     """,
# )
# # The following code was generated by Llama 3 70B:
# result = ((-5 + 93 * 4 - 0) * (4**4 - 7 + 0 * 5))
# print(result)
# complete_and_print(
#     "Give me the zip code for Menlo Park in JSON format with the field 'zip_code'",
# )
# # Likely returns the JSON and also "Sure! Here's the JSON..."
# complete_and_print(
#     """
#     You are a robot that only outputs JSON.
#     You reply in JSON format with the field 'zip_code'.
#     Example question: What is the zip code of the Empire State Building? Example answer: {'zip_code': 10118}
#     Now here is my question: What is the zip code of Menlo Park?
#     """,
# )
# # "{'zip_code': 94025}"
