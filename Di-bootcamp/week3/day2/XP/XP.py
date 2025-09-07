#1
# A company’s financial reports stored in an Excel file → Structured data (organized into rows, columns, numbers, and formulas).

# Photographs uploaded to a social media platform → Unstructured data (image files without inherent tabular format).

# A collection of news articles on a website → Unstructured data (textual data, though some metadata like date, author can be semi-structured).

# Inventory data in a relational database → Structured data (tables with defined fields: product ID, quantity, price, etc.).

# Recorded interviews from a market research study → Unstructured data (audio/video recordings, may need transcription for structure).

#3
import pandas as pd
import os
# -------------------------------
# 1. Load the datasets
# -------------------------------
dir_path = os.path.dirname(os.path.realpath(__file__))
file_path_train_df = os.path.join(dir_path, "train.csv")
file_path_iris_df = os.path.join(dir_path, "Iris_dataset.csv")

train_df = pd.read_csv(file_path_train_df)

print(train_df.head(), "\n")

#4
iris_df = pd.read_csv(file_path_iris_df)
print(iris_df.head(), "\n") 

#5
# 1. Create a simple DataFrame
data = {
    "Name": ["Alice", "Bob", "Charlie", "David"],
    "Age": [25, 30, 35, 40],
    "City": ["New York", "London", "Paris", "Berlin"]
}

df = pd.DataFrame(data)

# Display the DataFrame
print("DataFrame:")
print(df)

# 2. Export the DataFrame to an Excel file
# This will create a file named "output.xlsx" in the working directory
df.to_excel("output.xlsx", index=False)

# 3. Export the DataFrame to a JSON file
# This will create a file named "output.json" in the working directory
df.to_json("output.json", orient="records", indent=4)

print("\nData exported successfully to 'output.xlsx' and 'output.json'")

#6

# 1. Specify the path to your JSON file
url = "https://example.com/data.json"  # <-- replace with your actual URL
file_path_posts_df = os.path.join(dir_path, "posts.json")
#Read the JSON file into a Pandas DataFrame
df = pd.read_json(file_path_posts_df)

# 4. Display the first five entries
print(df.head())
