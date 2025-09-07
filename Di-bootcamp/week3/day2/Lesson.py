# Import required libraries
import pandas as pd
import numpy as np
from faker import Faker
import random

# Initialize Faker for generating fake but realistic data
fake = Faker()

# ------------------------------
# Step 1: Design the Dataset Structure
# ------------------------------
# Columns:
# - Product Name (string)
# - Sale Amount (float)
# - Date of Sale (datetime)
# - Customer Age (integer)

# Decide how many records (rows) we want to generate
num_records = 1000

# ------------------------------
# Step 2: Generate Synthetic Data
# ------------------------------

# Generate Product Names using Faker’s word generator
product_names = [fake.word().capitalize() for _ in range(num_records)] #create a list of random product names

# Generate Sale Amounts using numpy (random values between 5 and 500 USD)
sale_amounts = np.round(np.random.uniform(5, 500, num_records), 2)

# Generate Dates of Sale (random dates within the last 2 years)
dates_of_sale = [fake.date_between(start_date='-2y', end_date='today') for _ in range(num_records)]

# Generate Customer Ages (integers between 18 and 70)
customer_ages = np.random.randint(18, 71, num_records)

# ------------------------------
# Step 3: Compile the Dataset
# ------------------------------

# Combine all columns into a pandas DataFrame
sales_data = pd.DataFrame({
    "Product Name": product_names,
    "Sale Amount (USD)": sale_amounts,
    "Date of Sale": dates_of_sale,
    "Customer Age": customer_ages
})

# Display the first few rows of the dataset
print(sales_data.head())

# Save the dataset as a CSV file (optional)
sales_data.to_csv("synthetic_retail_sales.csv", index=False)
