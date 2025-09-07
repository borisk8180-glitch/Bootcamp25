import pandas as pd

data = pd.Series([1,2,3,4,5])
print(data)
print(type(data))
data = {
    'name': ['john', 'mary', 'peter', 'jeff', 'bill'],
    'age': [25, 30, 35, 40, 45],
    'gender': ['M', 'F', 'M', 'M', 'M'],
    'salary': [50000, 60000, 70000, 80000, 90000]
}
df = pd.DataFrame(data)
print(df)
