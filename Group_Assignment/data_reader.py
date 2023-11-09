
import pandas as pd

# read in the csv file
df = pd.read_csv('space_pirate_bonneroni.csv', index_col=0)

print(df.head())
# get the size of the dataset
size = df.shape

# get the column names
columns = df.columns.tolist()

# print the size and column names informatively
print(f"The dataset has {size[0]} rows and {size[1]} columns.")
print(f"The column names are: {', '.join(columns)}")

# get the maximum distance that has a label value of 1
max_distance = df[df['label'] == 1]['distance'].max()

print(f"The maximum distance that has a label value of 1 is {max_distance}")