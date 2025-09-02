#1
import random
import os

dir_path = os.path.dirname(os.path.realpath(__file__))
file_path = os.path.join(dir_path, "words.txt")
print(file_path)
# Step 1: Create the get_words_from_file function
def get_words_from_file(file_path):
    """
    Reads a file and returns a list of words.
    :param file_path: Path to the file containing words
    :return: List of words
    """
    with open(file_path, "r") as file:
        content = file.read()
    words = content.split()  # Split the content into words
    return words


# Step 2: Create the get_random_sentence function
# def get_random_sentence(length, file_path="words.txt"):
def get_random_sentence(length):

    """
    Generates a random sentence of a given length.
    :param length: Number of words in the sentence
    :param file_path: Path to the word list file
    :return: Random sentence (string)
    """
    words = get_words_from_file(file_path)  # Get the list of words
    random_words = random.choices(words, k=length)  # Select 'length' random words
    sentence = " ".join(random_words)  # Join the words into a sentence
    return sentence.lower()  # Convert to lowercase


# Step 3: Create the main function
def main():
    """
    Main function to handle program flow.
    """
    print("This program generates a random sentence from a word list.")
    print("You can choose the sentence length between 2 and 20 words.")

    # Ask user for input
    user_input = input("Enter the desired sentence length: ")

    # Validate input
    if not user_input.isdigit():
        print("Error: You must enter a number.")
        return

    length = int(user_input)

    if length < 2 or length > 20:
        print("Error: The length must be between 2 and 20.")
        return

    # Generate and print random sentence
    sentence = get_random_sentence(length)
    print("\nHere is your random sentence:")
    print(sentence)


# Run the program
if __name__ == "__main__":
    main()
#2
#2
import json

# Step 1: Load the JSON string
sampleJson = """{ 
   "company":{ 
      "employee":{ 
         "name":"emma",
         "payable":{ 
            "salary":7000,
            "bonus":800
         }
      }
   }
}"""

# Parse the JSON string into a Python dictionary
data = json.loads(sampleJson)

# Step 2: Access the nested “salary” key
salary = data["company"]["employee"]["payable"]["salary"]
print("Salary:", salary)  # Print the salary value

# Step 3: Add the “birth_date” key
# Add a new key "birth_date" to the employee dictionary
data["company"]["employee"]["birth_date"] = "1990-05-15"  # Example date

# Step 4: Save the JSON to a file
# Open a file in write mode and save the modified JSON
with open("modified_employee.json", "w") as file:
    json.dump(data, file, indent=4)  # indent=4 makes the file pretty-printed

print("Modified JSON has been saved to 'modified_employee.json'")