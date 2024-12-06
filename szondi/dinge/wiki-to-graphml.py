import networkx as nx
import pandas as pd

# Load your CSV data
df = pd.read_csv('query-idia.csv')

# Create a directed graph
G = nx.DiGraph()

# Add nodes and edges from the dataframe
for index, row in df.iterrows():
    G.add_edge(row['itemImage'], row['edgeLabel'], weight=row['weight'])

# Save the graph to a GraphML file
nx.write_graphml(G, 'output.graphml')
