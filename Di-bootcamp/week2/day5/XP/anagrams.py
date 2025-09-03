# anagrams.py
# ===================
# This file is responsible for the user interface (UI).
# It uses the AnagramChecker class to validate input and find anagrams.

from anagram_checker import AnagramChecker
import os

dir_path = os.path.dirname(os.path.realpath(__file__))
file_path = os.path.join(dir_path, "sowpods.txt")

def main():
    # Create an instance of AnagramChecker, passing the dictionary text file
    checker = AnagramChecker(file_path)  
    
    while True:
        print("\n--- ANAGRAM PROGRAM ---")
        print("1. Enter a word")
        print("2. Exit")
        choice = input("Choose an option: ").strip()
        
        if choice == "2":
            print("Goodbye!")
            break
        elif choice == "1":
            user_word = input("Enter a word: ").strip()
            
            # Validation: ensure input is a single word
            if " " in user_word:
                print("❌ Error: Please enter only one word.")
                continue
            
            # Validation: check if word contains only alphabetic characters
            if not user_word.isalpha():
                print("❌ Error: Word must contain only letters.")
                continue
            
            # Convert to lowercase for consistency
            user_word = user_word.lower()
            
            # Check if word is valid (exists in dictionary)
            if not checker.is_valid_word(user_word):
                print(f"❌ Error: '{user_word}' is not a valid English word.")
                continue
            
            # Get anagrams
            anagrams = checker.get_anagrams(user_word)
            
            # Display result
            print("\n✅ Word Information")
            print(f"Your word: {user_word}")
            print(f"Valid Word: YES")
            if anagrams:
                print(f"Anagrams found: {', '.join(anagrams)}")
            else:
                print("No anagrams found.")
        else:
            print("❌ Invalid choice. Please enter 1 or 2.")

# Run the program only if executed directly (not imported)
if __name__ == "__main__":
    main()