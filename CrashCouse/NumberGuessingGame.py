import random
print("🎲 Welcome to the Number Guessing Game!")
print("I'm thinking of a number between 1 and 100.")
print("You have 7 attempts to guess it. Good luck! 🍀\n")

# Generate random number
secret_number = random.randint(1, 100)
attempts = 7

for attempt in range(1, attempts + 1):
    try:
        guess = int(input(f"Attempt {attempt}/{attempts} - Enter your guess: "))
    except ValueError:
        print("⚠️ Please enter a valid number!")
        continue

    if guess < 1 or guess > 100:
        print("🚫 Out of range! Guess a number between 1 and 100.")
        continue

    if guess == secret_number:
        print(f"🎉 Congratulations! You guessed the number {secret_number} in {attempt} tries!")
        break
    elif guess < secret_number:
        print("📉 Too low!")
    else:
        print("📈 Too high!")
else:
    print(f"😢 Sorry, you've run out of attempts. The number was {secret_number}.")

