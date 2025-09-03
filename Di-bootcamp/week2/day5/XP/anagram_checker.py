# anagram_checker.py
# ===================
# This file defines the AnagramChecker class.
# The class loads a word list file into memory and provides methods
# to validate words and find anagrams for them.

class AnagramChecker:
    def __init__(self, word_list_file): #initialize the class with a word list file
        """
        Constructor method that loads the word list into memory.        
        :param word_list_file: Path to a text file containing words (one per line).
        """
        # Open the file and read all words into a Python set for fast lookup
        with open(word_list_file, "r") as f:
            # Strip newline characters and convert words to lowercase for consistency
            self.words = set(line.strip().lower() for line in f if line.strip()) # empty lines become false
            # convert to set for O(1) average time complexity on lookups
    
    def is_valid_word(self, word):
        """
        Check if the given word exists in the loaded word list.
        
        :param word: String input word
        :return: True if word exists in dictionary, False otherwise
        """
        return word.lower() in self.words
    
    def is_anagram(self, word1, word2):
        """
        Check if two words are anagrams of each other.
        
        :param word1: First word
        :param word2: Second word
        :return: True if both words are anagrams, False otherwise
        """
        # Words must not be identical
        if word1.lower() == word2.lower():
            return False
        
        # Sort letters of both words and compare
        return sorted(word1.lower()) == sorted(word2.lower())
    
    def get_anagrams(self, word): #sample word
        """
        Find all anagrams of a given word from the word list.
        
        :param word: Input word
        :return: List of anagrams found in the dictionary
        """
        return [w for w in self.words if self.is_anagram(word, w)] 
        # self.words - set of words from file and compare with the sample word
        # return as list if anagram is found