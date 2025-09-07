import random
import os
import sys

python_path = os.path.dirname(sys.executable)
python_version = sys.version
print(f"Python Path: {python_path}")
print(f"Python Version: {python_version}")  
#1 Ask for user input
user_string = input("Enter a string (must be exactly 10 characters long): ")

#2 Check string length
if len(user_string) < 10:
    print("String not long enough.")
elif len(user_string) > 10:
    print("String too long.")
else:
    print("Perfect string!")

#3 Print first and last characters
    print("First character:", user_string[0])
    print("Last character:", user_string[-1])

#4 Build the string character by character
    print("\nBuilding the string step by step:")
    for i in range(1, len(user_string) + 1):
        print(user_string[:i])

#5 Bonus: jumble the string
    chars = list(user_string)        # convert string to list of characters
    random.shuffle(chars)            # shuffle in place
    jumbled_string = ''.join(chars)  # convert back to string
    print("\nJumbled string:", jumbled_string)