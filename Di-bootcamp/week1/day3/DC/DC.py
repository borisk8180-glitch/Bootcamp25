# ask user for a word and store it in a variable
word = input("Enter a word: ")
# create a dictionary to store characters and their indices
char_indices = {}
#iterate through the word and populate the dictionary with characters as keys 
# and their indices as values
#use 'for' loop to iterate through each character in the word
for index, char in enumerate(word):
    #check if the character is already a key in the dictionary
    if char in char_indices:
        #modify the entry - append the index to the list of indices for that character
        char_indices[char].append(index)
    else:
        #create a NEW ENTRY in the dictionary with the character as the key
        # and a list containing the current index as the value
        char_indices[char] = [index]

print(char_indices)
#-------------------------------------------------
#2
items_purchase = {"Water": "$1", "Bread": "$3", "TV": "$1,000", "Fertilizer": "$20"}
wallet = "$300"

# items_purchase = {"Apple": "$4", "Honey": "$3", "Fan": "$14", "Bananas": "$4", "Pan": "$100", "Spoon": "$2"}
# wallet = "$100"

# items_purchase = {"Phone": "$999", "Speakers": "$300", "Laptop": "$5,000", "PC": "$1200"}
# wallet = "$1"

# Clean wallet amount
#since string is immutable, we need to create a new string by replacing $ and , with nothing
#and then convert to integer
wallet_amount = int(wallet.replace("$", "").replace(",", ""))
#replace $ and , with nothing and convert to integer

# Clean item prices and determine affordable items
affordable = []
for item, price in items_purchase.items():
    # Clean price amount: replace $ and , with nothing and convert to integer
    price_amount = int(price.replace("$", "").replace(",", ""))
    #check if the price is less than or equal to the wallet amount
    if price_amount <= wallet_amount:
        affordable.append(item)

# Sort and output
print('')
if not affordable:
    print("Nothing")
else:
    print(sorted(affordable))