#Hangman Game
import random

# Word list
wordslist = [
    'correction', 'childish', 'beach', 'python', 'assertive',
    'interference', 'complete', 'share', 'credit card', 'rush', 'south'
            ]

# Choose a random word or phrase
word = random.choice(wordslist).lower()

# define a set to store guessed letters
guessed_letters = set()

# Iterate through the word and display word with * for letters (keep spaces as they are)
display = ["*" if letter != " " else " " for letter in word]
#True part - if - [var == condition] - else False part - for var - in iterable
# Hangman parts (6 allowed mistakes)
hangman_parts = ["head", "body", "left arm", "right arm", "left leg", "right leg"]
mistakes = 0 #counter for wrong guesses

print("Welcome to Hangman!")
#convert list to string for initial display
print(" ".join(display))

# Game loop
while mistakes < len(hangman_parts) and "*" in display:
    guess = input("Guess a letter: ").lower()

    # Check if already guessed
    if guess in guessed_letters:
        print("You already guessed that letter. Try again.")
        continue

    guessed_letters.add(guess) #add the guessed letter to the set

    # If guess is correct
    if guess in word:
        for i, letter in enumerate(word): #iterate through the word to find all indexes of the letter
            if letter == guess:
                display[i] = guess #place the guessed letter in the correct position as indexes are the same
        print("Good guess:", " ".join(display))
    else:
        # Wrong guess
        mistakes += 1
        print(f"Wrong guess! Added {hangman_parts[mistakes-1]}") #show the body part(index = number of mistakes - 1)
        print(" ".join(display))

# Win or lose
if "*" not in display: #display list has no * left
    print("🎉 Congratulations! You guessed the word:", word)
else:
    print("💀 Game over! The word was:", word)