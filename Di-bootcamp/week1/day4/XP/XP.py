import random

#1
def display_message():
    print("I am learning about functions in Python.")

display_message()

#2
def favorite_book(title):
    print(f"One of my favorite books is {title}.")

favorite_book("Alice in Wonderland")
#3
def describe_city(city, country="Unknown"):
    print(f"{city} is in {country}.")

describe_city("Reykjavik", "Iceland")
describe_city("Paris")
describe_city("Tokyo", "Japan")
4
def guess_number(user_number):
    user_number = int(input("Guess a number between 1 and 100: "))
    random_number = random.randint(1, 100)
    if user_number == random_number:
        print("Congratulations! You guessed the correct number!")
    else:
        print(f"Sorry, you guessed {user_number}, but the number was {random_number}.")

guess_number(42)
#5
def make_shirt(size="large", text="I love Python"):
    print(f"Making a {size} shirt with the message: '{text}'.")

# Call with default values
make_shirt()
# Call with custom size, default text
make_shirt(size="medium")
# Call with custom size and custom text
make_shirt("small", "Hello, World!")
# Call using keyword arguments (bonus)
make_shirt(size="extra large", text="Keep Calm and Code On")
make_shirt(size="small", text="Hello")
#6
magician_names = ['Harry Houdini', 'David Blaine', 'Criss Angel']

def show_magicians(names):
    for name in names:
        print(name)

def make_great(names):
    for i in range(len(names)):
        names[i] = names[i] + " the Great" 

make_great(magician_names)
show_magicians(magician_names)

#7
def get_random_temp(season=None):
    if season == "winter":
        return round(random.uniform(-10, 8), 1)
    elif season == "spring":
        return round(random.uniform(8, 20), 1)
    elif season == "summer":
        return round(random.uniform(20, 40), 1)
    elif season == "autumn":
        return round(random.uniform(5, 18), 1)
    else:
        return round(random.uniform(-10, 40), 1)

def main():
    month = input("Enter the month as a number (1-12): ")
    try:
        month = int(month)
        if month in [12, 1, 2]:
            season = "winter"
        elif month in [3, 4, 5]:
            season = "spring"
        elif month in [6, 7, 8]:
            season = "summer"
        elif month in [9, 10, 11]:
            season = "autumn"
        else:
            season = None
    except ValueError:
        season = None

    temp = get_random_temp(season)
    print(f"The temperature right now is {temp} degrees Celsius.")

    if temp < 0:
        print("Brrr, that’s freezing! Wear some extra layers today.")
    elif 0 <= temp <= 16:
        print("Quite chilly! Don’t forget your coat.")
    elif 16 < temp <= 23:
        print("Nice weather.")
    elif 23 < temp <= 32:
        print("A bit warm, stay hydrated.")
    elif 32 < temp <= 40:
        print("It’s really hot! Stay cool.")

main()