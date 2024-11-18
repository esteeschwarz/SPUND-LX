import csv
from mastodon import Mastodon
import sys
ACCESS_TOKEN = sys.argv[1]
INSTANCE_URL = sys.argv[2]
query = sys.argv[3]
output_file = sys.argv[4]

print(ACCESS_TOKEN)
print(INSTANCE_URL)
print(query)
print(output_file)

# Authenticate with the Mastodon API
mastodon = Mastodon(
    access_token=ACCESS_TOKEN,
    api_base_url=INSTANCE_URL
)

# Define the search query
search_query = query
# Query posts containing the search term
results = mastodon.search(search_query, resolve=True)

# Define the CSV file path
csv_file_path = output_file
# Open the CSV file for writing
with open(csv_file_path, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    # Write the header
    writer.writerow(['User', 'Post'])

    # Write the extracted posts
    for status in results['statuses']:
        user = status["account"]["acct"]
        post = status["content"]
        writer.writerow([user, post])

print(f'Results written to {csv_file_path}')


# Print the extracted posts
for status in results['statuses']:
    print(f'User: {status["account"]["acct"]}')
    print(f'Post: {status["content"]}')
    print('---')
