# Step 1: Create the Farm Class
class Farm:    
    def __init__(self, farm_name):# Step 2: Implement __init__
        self.name = farm_name
        self.animals = {}

    # Step 3: Implement add_animal
    def add_animal(self, animal_type, count=1):
        if animal_type in self.animals:
            self.animals[animal_type] += count
        else:
            self.animals[animal_type] = count

    # Step 4: Implement get_info
    def get_info(self): #method to return a formatted string
        output = f"{self.name}'s Farm\n"
        output += "-" * 20 + "\n" #adds a line of dashes
        for animal, count in self.animals.items(): #iterates through the dictionary items(key-value pairs)
            output += f"{animal:<10} : {count}\n"  #formats the animal count and adds it to be left-aligned within a 10-character width
        output += "-" * 20 + "\n" #adds another line of dashes
        output += "E-I-E-I-0!"
        return output

    # Step 6: Implement get_animal_types
    def get_animal_types(self):
        return sorted(self.animals.keys()) #use sorted() to return a sorted list of the dictionary keys (animal types)

    # Step 7: Implement get_short_info
    def get_short_info(self):
        animal_list = []
        for animal, count in self.animals.items(): #iterates through the dictionary items (key-value pairs)
            if count > 1:
                animal_list.append(animal + "s") #pluralize the animal name by adding 's' if count > 1
            else:
                animal_list.append(animal)
        sorted_animals = sorted(animal_list) #sorts the list of animal names alphabetically
        
        if len(sorted_animals) > 1:
            animals_str = ", ".join(sorted_animals[:-1]) + " and " + sorted_animals[-1]
        else:
            animals_str = sorted_animals[0]
        
        return f"{self.name}'s farm has {animals_str}."


# Step 5 + Step 6 + Step 7: Test the code
my_farm = Farm("McDonald")

my_farm.add_animal("cow", 3)
my_farm.add_animal("goat", 2)
my_farm.add_animal("sheep", 5)

print(my_farm.get_info())
print("\nAnimal types:", my_farm.get_animal_types())
print(my_farm.get_short_info())
