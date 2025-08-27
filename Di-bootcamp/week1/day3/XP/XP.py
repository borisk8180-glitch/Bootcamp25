#1
keys = ['Ten', 'Twenty', 'Thirty']
values = [10, 20, 30]

result_dict = dict(zip(keys, values))
print(result_dict)

#2
#setting the dictionary
family = {"rick": 43, 'beth': 13, 'morty': 5, 'summer': 8}
total_cost = 0
#looping through the dictionary to calculate the total cost
#retrieveing keys and values
for name, age in family.items():
    #populating the price variable with the correct price based on age
    if age < 3:
        price = 0
    elif 3 <= age <= 12:
        price = 10
    else:
        price = 15
    #printing the name and price of each family member
    print(f"{name.capitalize()}: ${price}")
    #adding the price to the total cost
    total_cost += price

print(f"Total cost: ${total_cost}")

#3
brand = {
    "name": "Zara",
    "creation_date": 1975,
    "creator_name": "Amancio Ortega Gaona",
    "type_of_clothes": ["men", "women", "children", "home"],
    "international_competitors": ["Gap", "H&M", "Benetton"],
    "number_stores": 7000,
    "major_color": {
        "France": "blue",
        "Spain": "red",
        "US": ["pink", "green"]
    }
}

# Change the value of number_stores to 2
brand["number_stores"] = 2

# Print a sentence describing Zara’s clients using the type_of_clothes key
print(f"Zara's clients are: {', '.join(brand['type_of_clothes'])}.")
#join() method is used to join the elements of the list together into a single string,
# with each element separated by commas.

# Add a new key 'country_creation' with the value Spain
brand["country_creation"] = "Spain"

# Check if international_competitors exists and add “Desigual” to the list
if "international_competitors" in brand:
    brand["international_competitors"].append("Desigual")

# Delete the creation_date key
brand.pop("creation_date", None)
#pop() method is used to remove the specified key from the dictionary.
#The second argument None is provided to avoid KeyError if the key does not exist.

# Print the last item in international_competitors
print("Last international competitor:", brand["international_competitors"][-1])

# Print the major colors in the US
print("Major colors in the US:", ", ".join(brand["major_color"]["US"]))

# Print the number of keys in the dictionary
print("Number of keys in brand:", len(brand))

# Print all keys of the dictionary
print("Keys in brand:", list(brand.keys()))

# Bonus
more_on_zara = {
    "creation_date": 1975,
    "number_stores": 10000
}
brand.update(more_on_zara)
#update() method is used to update the dictionary with key-value pairs from 
# another dictionary (more_on_zara in this case).
#The updated dictionary will contain all the key-value pairs from the original 
# dictionary (brand) and the additional key-value pairs from more_on_zara.
print("Updated brand dictionary:", brand)

#4
users = ["Mickey", "Minnie", "Donald", "Ariel", "Pluto"]

# 1. Dictionary with character as key and index as value
disney_users_A = {user: idx for idx, user in enumerate(users)}
#enumerate() method is used to iterate over the elements of a sequence (in this case, 
# the list users) 
# and simultaneously get both the index and the value of each element.
#The resulting dictionary will have the characters as keys and their corresponding 
# indices as values.
print("disney_users_A:", disney_users_A)

# 2. Dictionary with index as key and character as value
disney_users_B = {idx: user for idx, user in enumerate(users)}
print("disney_users_B:", disney_users_B)

# 3. Dictionary with character as key and index as value, sorted alphabetically by character
disney_users_C = {user: idx for idx, user in enumerate(sorted(users))}
print("disney_users_C:", disney_users_C)