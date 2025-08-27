#1
# Step 1: Get Input
words = input("Enter words separated by commas: ")

# Step 2: Split the String
word_list = words.split(',')#create a list of words from the input string separated by commas

# Step 3: Sort the List
word_list.sort()

# Step 4: Join the Sorted List back into a String
sorted_words = ','.join(word_list)#populate a new string with the sorted words separated by commas

# Step 5: Print the Result
print(sorted_words)

#2
# Step 1: Define the Function
def longest_word(sentence):
    # Step 2: Split the Sentence into Words
    words = sentence.split()
    
    # Step 3: Initialize Variables
    longest = ""
    
    # Step 4: Iterate Through the Words
    for word in words:
        # Step 5: Compare Word Lengths
        if len(word) > len(longest):
            longest = word
    
    # Step 6: Return the Longest Word
    return longest


# Example usage
sentence = "Margaret's toy is a pretty doll."
print("The longest word is:", longest_word(sentence))