print("=== How Much Sleep Do Americans Really Get? Dataset ===")
# Import necessary libraries
import pandas as pd
import os
# -------------------------------
# 1. Load the datasets
# -------------------------------
dir_path = os.path.dirname(os.path.realpath(__file__))
file_path_sleep_df = os.path.join(dir_path, "Time Americans Spend Sleeping.csv")
file_path_disorder_df = os.path.join(dir_path, "Mental health Depression disorder Data.csv")
file_path_approvals_df = os.path.join(dir_path, "Mental health Depression disorder Data.csv")

sleep_df = pd.read_csv(file_path_sleep_df)
mental_health_df = pd.read_csv(file_path_disorder_df)
credit_card_df = pd.read_csv(file_path_approvals_df)

# -------------------------------
# 2. Display the first few rows of each dataset
# -------------------------------
print("=== How Much Sleep Do Americans Really Get? Dataset ===")
print(sleep_df.head(2), "\n")
# print(sleep_df['Period'], "\n")
# print(sleep_df['sleeping'] > 8, "\n")
# print(credit_card_df.groupby('Avg hrs per day sleeping').mean(), "\n")
# print(credit_card_df[''Bipolar disorder (%)'].type, "\n")
# print(int(credit_card_df['Bipolar disorder (%)']) > 5, "\n")
# print(credit_card_df.describe(), "\n")
print("=== Global Trends in Mental Health Disorder Dataset ===")
print(mental_health_df.head(), "\n")

print("=== Credit Card Approvals Dataset ===")
print(credit_card_df.head(), "\n")

# -------------------------------
# 3. Provide a short description of each dataset
# -------------------------------

print("=== Dataset Descriptions ===")
print("1. Sleep Dataset: Contains information on average sleep duration among Americans, "
      "possibly broken down by age, gender, region, or year.")

print("\n2. Mental Health Dataset: Provides global statistics about mental health disorders "
      "such as depression or anxiety, categorized by country, year, and prevalence rate.")

print("\n3. Credit Card Approvals Dataset: Includes applications for credit cards with details "
      "such as age, income, employment status, and whether the application was approved.")

print("\n===" + "Basic Data Analysis with Google Colab")
# Import required libraries
import matplotlib.pyplot as plt
import seaborn as sns

# -------------------------------
# 1. Load the dataset
# -------------------------------
data = pd.read_csv(file_path_sleep_df)

# -------------------------------
# 2. Select a quantitative column for analysis
# -------------------------------
# Example: let's say the dataset has a column "Average Sleep Hours"
column = "Avg hrs per day sleeping"

# -------------------------------
# 3. Calculate mean, median, and mode
# -------------------------------
#try:
mean_val = data[column].mean()
median_val = data[column].median()
mode_val = data[column].mode()[0]   # mode() can return multiple values, take the first one

print(f"Mean of {column}: {mean_val}")
print(f"Median of {column}: {median_val}")
print(f"Mode of {column}: {mode_val}")

# -------------------------------
# 4i. Visualization
# -------------------------------
# Create a histogram to visualize the distribution of sleep hours
plt.figure(figsize=(8, 5))
sns.histplot(data[column], bins=10, kde=True, color="skyblue")
plt.title(f"Distribution of {column}")
plt.xlabel(column)
plt.ylabel("Frequency")
plt.show()
#except KeyError:
print(f"Column {column} not available in the dataset.")
# -------------------------------
#6
print("\n=== Develop observation skills for data analysis ===")
# Step 1: Load the dataset
data = pd.read_csv(file_path_sleep_df)

# Step 2: Display the first rows to understand the dataset structure
print("Preview of the dataset:")
print(data.head())

# Step 3: Get information about the dataset (column names, data types, missing values)
print("\nDataset info:")
data.info()

print("\nSummary statistics:")
print(data.describe(include="all"))

# Step 4: Identify interesting columns for analysis
# For example, let's assume the dataset includes:
# - "Average Sleep Hours" → numeric, useful for trend analysis
# - "Age Group" → categorical, useful for group comparisons
# - "Gender" → categorical, useful for exploring differences between groups
# - "Work Status" → categorical, might influence sleep patterns
# - "Year" → numeric or datetime, useful for tracking changes over time

# Explanation of choice:
# 1. "Average Sleep Hours": central to the research question (how much sleep Americans get).
# 2. "Age Group": allows us to compare whether younger/older groups sleep differently.
# 3. "Gender": we can analyze if there are differences in sleep patterns by gender.
# 4. "Work Status": might reveal how employment/unemployment affects sleep.
# 5. "Year": helps detect trends over time, e.g., changes in sleep due to societal shifts.

interesting_columns = ["Average Sleep Hours", "Age Group", "Gender", "Work Status", "Year"]

print("\nSelected interesting columns for analysis:")
print(interesting_columns)

