#1 Create a Cat class with name and age attributes.
# Step 1: Create Cat Class and Cat Objects
class Cat:
    def __init__(self, name, age):
        self.name = name
        self.age = age

# create three Cat objects
cat1 = Cat("Mittens", 3)
cat2 = Cat("Whiskers", 7)
cat3 = Cat("Shadow", 5)

# Step 2: Function to find the oldest cat
def find_oldest_cat(cat_a, cat_b, cat_c):
    oldest = cat_a
    if cat_b.age > oldest.age:
        oldest = cat_b
    if cat_c.age > oldest.age:
        oldest = cat_c
    return oldest

# Step 3: Print the oldest cat’s details
oldest_cat = find_oldest_cat(cat1, cat2, cat3)
print(f"The oldest cat is {oldest_cat.name}, and is {oldest_cat.age} years old.")

#2
# Step 1: Create the Dog Class
class Dog:
    def __init__(self, name, height):
        self.name = name
        self.height = height

    def bark(self):
        print(f"{self.name} goes woof!")

    def jump(self):
        print(f"{self.name} jumps {self.height * 2} cm high!")

# Step 2: Create Dog Objects
davids_dog = Dog("Rex", 60)
sarahs_dog = Dog("Teacup", 20)

# Step 3: Print Dog Details and Call Methods
print(f"David's dog is named {davids_dog.name} and is {davids_dog.height} cm tall.")
davids_dog.bark()
davids_dog.jump()

print(f"Sarah's dog is named {sarahs_dog.name} and is {sarahs_dog.height} cm tall.")
sarahs_dog.bark()
sarahs_dog.jump()

# Step 4: Compare Dog Sizes
if davids_dog.height > sarahs_dog.height:
    print(f"{davids_dog.name} is bigger than {sarahs_dog.name}.")
elif davids_dog.height < sarahs_dog.height:
    print(f"{sarahs_dog.name} is bigger than {davids_dog.name}.")
else:
    print(f"{davids_dog.name} and {sarahs_dog.name} are the same size!")

#3
# Step 1: Create the Song Class
class Song:
    def __init__(self, lyrics):
        self.lyrics = lyrics

    def sing_me_a_song(self):
        for line in self.lyrics:
            print(line)

# Example usage
stairway = Song([
    "There’s a lady who's sure",
    "all that glitters is gold",
    "and she’s buying a stairway to heaven"
    ])

# Call the method
stairway.sing_me_a_song()

#4
# Step 1: Define the Zoo Class
class Zoo:
    def __init__(self, zoo_name):
        self.zoo_name = zoo_name
        self.animals = []

    # Add new animal if it's not already in the zoo
    def add_animal(self, new_animal):
        if new_animal not in self.animals:
            self.animals.append(new_animal)

    # Print all animals currently in the zoo
    def get_animals(self):
        print(f"Animals in {self.zoo_name}: {self.animals}")

    # Sell (remove) an animal if it exists
    def sell_animal(self, animal_sold):
        if animal_sold in self.animals:
            self.animals.remove(animal_sold)

    # Sort and group animals alphabetically
    def sort_animals(self):
        sorted_animals = sorted(self.animals)
        grouped_animals = {}
        
        #create groups based on the first letter of each animal's name
        for animal in sorted_animals: 
            first_letter = animal[0].upper() # Convert to uppercase for consistency
            if first_letter not in grouped_animals: # If the letter key doesn't exist, create it
                grouped_animals[first_letter] = []
            grouped_animals[first_letter].append(animal)
        return grouped_animals

    # Print grouped animals
    def get_groups(self):
        grouped = self.sort_animals()
        for letter, group in grouped.items():
            print(f"{letter}: {group}")


# Example usage:
zoo = Zoo("Safari Park")

zoo.add_animal("Lion")
zoo.add_animal("Zebra")
zoo.add_animal("Cat")
zoo.add_animal("Cougar")
zoo.add_animal("Giraffe")
zoo.add_animal("Bear")
zoo.add_animal("Baboon")

zoo.get_animals()

zoo.sell_animal("Cat")
zoo.get_animals()

zoo.get_groups()

# Step 1: Define the Zoo Class
class Zoo:
    def __init__(self, zoo_name):
            self.zoo_name = zoo_name
            self.animals = []

    def add_animal(self, new_animal):
        if new_animal not in self.animals:
            self.animals.append(new_animal)

    def get_animals(self):
        print(f"Animals in {self.zoo_name}: {self.animals}")

    def sell_animal(self, animal_sold):
        if animal_sold in self.animals:
            self.animals.remove(animal_sold)

    def sort_animals(self):
        sorted_animals = sorted(self.animals)
        grouped_animals = {}
        for animal in sorted_animals:
            first_letter = animal[0].upper()
            if first_letter not in grouped_animals:
                grouped_animals[first_letter] = []
            grouped_animals[first_letter].append(animal)
        return grouped_animals

    def get_groups(self):
        grouped = self.sort_animals()
        for letter, group in grouped.items():
            print(f"{letter}: {group}")


# Step 2: Create a Zoo Object
my_zoo = Zoo("Wonderland Zoo")

# Step 3: Call the Zoo Methods
# Add animals
my_zoo.add_animal("Lion")
my_zoo.add_animal("Zebra")
my_zoo.add_animal("Cat")
my_zoo.add_animal("Cougar")
my_zoo.add_animal("Giraffe")
my_zoo.add_animal("Bear")
my_zoo.add_animal("Baboon")

# Display animals
my_zoo.get_animals()

# Sell an animal
my_zoo.sell_animal("Cat")
my_zoo.get_animals()

# Show groups
print("\nGrouped animals:")
my_zoo.get_groups()

