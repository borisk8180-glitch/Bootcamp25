#1
class Currency:
    def __init__(self, currency, amount):
        self.currency = currency
        self.amount = amount

    def __str__(self):
        # pluralize currency if amount > 1
        if self.amount == 1:
            return f"{self.amount} {self.currency}"
        else:
            return f"{self.amount} {self.currency}s"

    def __repr__(self):
        return self.__str__()

    def __int__(self):
        return self.amount

    def __add__(self, other):
        if isinstance(other, int):
            return self.amount + other
        elif isinstance(other, Currency):
            if self.currency != other.currency:
                raise TypeError(f"Cannot add between Currency type <{self.currency}> and <{other.currency}>")
            return self.amount + other.amount
        else:
            return NotImplemented

    def __iadd__(self, other):
        if isinstance(other, int):
            self.amount += other
        elif isinstance(other, Currency):
            if self.currency != other.currency:
                raise TypeError(f"Cannot add between Currency type <{self.currency}> and <{other.currency}>")
            self.amount += other.amount
        else:
            return NotImplemented
        return self

c1 = Currency('dollar', 5)
c2 = Currency('dollar', 10)
c3 = Currency('shekel', 1)
c4 = Currency('shekel', 10)

#the comment is the expected output
print(c1)
# '5 dollars'

print(int(c1))
# 5

print(repr(c1))
# '5 dollars'

print(c1 + 5)
# 10

print(c1 + c2)
# 15

print(c1) 
# 5 dollars

c1 += 5
print(c1)
# 10 dollars

c1 += c2
print(c1)
# 20 dollars

# print(c1 + c3)
# TypeError: Cannot add between Currency type <dollar> and <shekel>

#2
# func.py
# exercise_one.py

#3
import string
import random

# Step 2: создать строку из всех букв (верхний и нижний регистр)
letters = string.ascii_letters   # включает 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

# Step 3: сгенерировать случайную строку длиной 5
random_string = ""
for i in range(5):
    random_char = random.choice(letters)   # берём случайную букву
    random_string += random_char           # прибавляем к строке

print("Random string:", random_string)

#4
import datetime

def show_current_date():
    # Step 2: получить текущую дату
    today = datetime.date.today()
    
    # Step 3: вывести дату
    print("Today's date is:", today)

# Вызов функции
show_current_date()

#5
import datetime

def time_until_new_year():
    # Step 2: получить текущую дату и время
    now = datetime.datetime.now()
    
    # Step 3: создать объект даты для 1 января следующего года
    next_year = now.year + 1
    new_year = datetime.datetime(year=next_year, month=1, day=1, hour=0, minute=0, second=0)
    
    # Step 4: вычислить разницу
    time_left = new_year - now
    
    # Step 5: вывести разницу
    print("Time left until New Year:", time_left)

# Вызов функции
time_until_new_year()

#6
import datetime

def minutes_lived(birthdate_str):
    """
    Function that calculates how many minutes a person has lived.
    :param birthdate_str: birthdate in 'YYYY-MM-DD' format
    """
    # Step 1: Parse the input string into a datetime object
    birthdate = datetime.datetime.strptime(birthdate_str, "%Y-%m-%d")
    
    # Step 2: Get the current date and time
    now = datetime.datetime.now()
    
    # Step 3: Calculate the time difference
    time_lived = now - birthdate
    
    # Step 4: Convert time lived into minutes
    minutes = int(time_lived.total_seconds() / 60)
    
    # Step 5: Display the result
    print(f"You have lived approximately {minutes} minutes.")

# Example usage
minutes_lived("1990-05-15")

#7
# Step 2: Import the faker module
from faker import Faker

# Step 3: Create an empty list to store users
users = []

# Step 4: Create a function to add users
def generate_users(n):
    """
    Generate n fake users and store them in the global 'users' list.
    Each user is a dictionary with keys: name, address, language_code.
    """
    fake = Faker()  # create a Faker instance
    for _ in range(n):
        user = {
            "name": fake.name(),
            "address": fake.address(),
            "language_code": fake.language_code()
        }
        users.append(user)

# Step 5: Call the function and print the list
generate_users(5)  # generate 5 fake users
for user in users:
    print(user)