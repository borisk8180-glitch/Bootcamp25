# Import pandas library
import pandas as pd

# Step 1: Create a dictionary with bookstore sales data
# Each key represents a column, and each list represents the data in that column.
data = {
    'Book Title': [
        'The Great Gatsby',
        'To Kill a Mockingbird',
        '1984',
        'Pride and Prejudice',
        'The Catcher in the Rye'
    ],
    'Author': [
        'F. Scott Fitzgerald',
        'Harper Lee',
        'George Orwell',
        'Jane Austen',
        'J.D. Salinger'
    ],
    'Genre': [
        'Classic',
        'Classic',
        'Dystopian',
        'Classic',
        'Classic'
    ],
    'Price': [
        10.99,
        8.99,
        7.99,
        11.99,
        9.99
    ],
    'Copies Sold': [
        500,
        600,
        800,
        300,
        450
    ]
}

# Step 2: Convert the dictionary into a pandas DataFrame
df = pd.DataFrame(data)

# --- Exploring the dataset ---

# View the first few rows of the dataset
print("First rows of the dataset:")
print(df.head(), "\n")  # head() shows the first 5 rows by default

# Get a statistical summary of numerical columns (Price and Copies Sold)
print("Statistical summary of numerical columns:")
print(df.describe(), "\n")

# Get a concise summary of the DataFrame
print("Concise summary of the DataFrame:")
print(df.info(), "\n")

# Sort the DataFrame by Price (ascending order)
print("Books sorted by Price:")
print(df.sort_values(by='Price'), "\n")

# Sort the DataFrame by Copies Sold (descending order)
print("Books sorted by Copies Sold (highest first):")
print(df.sort_values(by='Copies Sold', ascending=False), "\n")

# Filter: show only Classic books
print("Books in the 'Classic' genre:")
print(df[df['Genre'] == 'Classic'], "\n")

# Filter: show books with Price greater than $9.00
print("Books with Price greater than $9.00:")
print(df[df['Price'] > 9.00], "\n")

# Group by Author and sum up Copies Sold
# (useful if an author has multiple books in the dataset)
print("Total Copies Sold per Author:")
print(df.groupby('Author')['Copies Sold'].sum(), "\n")
