import string
import re

# Part I: Analyzing a Simple String
class Text:
    def __init__(self, text):
        """
        Initialize the Text object with a string.
        :param text: String to analyze
        """
        self.text = text

    def word_frequency(self, word):
        """
        Count the frequency of a specific word in the text.
        :param word: Word to count
        :return: Count of the word or None if not found
        """
        words = self.text.split() # Split the text into words, putting them in a list
        count = words.count(word) # Count occurrences of the word parameter in the list
        return count if count > 0 else None

    def most_common_word(self):
        """
        Find the most common word in the text.
        :return: The most frequent word
        """
        words = self.text.split() # Split the text into words, putting them in a list
        frequency = {}

        # Count word frequencies
        for word in words:
            frequency[word] = frequency.get(word, 0) + 1 #find the word in the dictionary, 
                                        # if it's not there, set it to 0, then add 1 to it

        # Find the word with the maximum frequency
        most_common = max(frequency, key=frequency.get)
        return most_common

    def unique_words(self):
        """
        Get a list of unique words in the text.
        :return: List of unique words
        """
        words = self.text.split()
        unique = set(words) # set automatically removes duplicates
        return list(unique)

    @classmethod
    def from_file(cls, file_path):
        """
        Create a Text instance from a file.
        :param file_path: Path to the text file
        :return: Text object
        """
        with open(file_path, "r") as file:
            content = file.read()
        return cls(content)


# Part II: Text Modification
class TextModification(Text):
    def remove_punctuation(self):
        """
        Remove punctuation from the text.
        :return: Modified text without punctuation
        """
        no_punct = self.text.translate(str.maketrans("o", "x", string.punctuation))
        """
        The translate() method returns a string where some specified characters are replaced with the character
        described in a dictionary, or in a mapping table.
        The mapping table is created using the str.maketrans() static method, which maps characters
        to their replacements or marks them for deletion
        """
        return no_punct

    def remove_stop_words(self):
        """
        Remove common English stop words from the text.
        :return: Modified text without stop words
        """
        # Example stop words list (could be extended with NLTK or other libraries)
        stop_words = {"a", "the", "is", "in", "at", "to", "and", "of", "on", "it"}

        words = self.text.split() # Split the text into words, putting them in a list
        filtered_words = [word for word in words if word.lower() not in stop_words] # List comprehension to filter out stop words
        return " ".join(filtered_words) # Join the filtered words back into a string

    def remove_special_characters(self):
        """
        Remove special characters using regex.
        :return: Modified text without special characters
        """
        cleaned_text = re.sub(r"[^A-Za-z0-9\s]", "", self.text)
        return cleaned_text


# Example usage
if __name__ == "__main__":
    sample_text = "Hello world! Hello Python. Python is great, and Python is fun."
    
    # Analyze text
    text = Text(sample_text)
    print("Frequency of 'Python':", text.word_frequency("Python"))
    print("Most common word:", text.most_common_word())
    print("Unique words:", text.unique_words())

    # Modify text
    mod_text = TextModification(sample_text)
    print("\nWithout punctuation:", mod_text.remove_punctuation())
    print("Without stop words:", mod_text.remove_stop_words())
    print("Without special characters:", mod_text.remove_special_characters())
