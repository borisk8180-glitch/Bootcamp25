#1
# Базовый класс для группы питомцев
class Pets:
    def __init__(self, animals):
        self.animals = animals

    def walk(self):
        for animal in self.animals:
            print(animal.walk())


# Базовый класс Кошка
class Cat:
    is_lazy = True

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def walk(self):
        return f"{self.name} is just walking around."


# Подклассы кошек
class Bengal(Cat):
    def sing(self, sounds):
        return f"{sounds}"


class Chartreux(Cat):
    def sing(self, sounds):
        return f"{sounds}"


# ✅ Step 1: Создаём новый подкласс Siamese
class Siamese(Cat):
    def sing(self, sounds="Meooow"):
        return f"{self.name} sings: {sounds}"


# ✅ Step 2: Создаём список котов
bengal_obj = Bengal("Luna", 3)
chartreux_obj = Chartreux("Milo", 5)
siamese_obj = Siamese("Simba", 2)

all_cats = [bengal_obj, chartreux_obj, siamese_obj]
# all_cats = bengal_obj.__str__, chartreux_obj.__str__, siamese_obj.__str__
# print(all_cats)

# ✅ Step 3: Создаём экземпляр Pets
sara_pets = Pets(all_cats)

# ✅ Step 4: Прогуливаем всех котов
sara_pets.walk()

#2
# Step 1: Create the Dog Class
class Dog:
    def __init__(self, name, age, weight):
        self.name = name
        self.age = age
        self.weight = weight

    def bark(self):
        return f"{self.name} is barking"

    def run_speed(self):
        return (self.weight / self.age) * 10

    def fight(self, other_dog):
        self_power = self.run_speed() * self.weight
        other_power = other_dog.run_speed() * other_dog.weight

        if self_power > other_power:
            return f"{self.name} won the fight against {other_dog.name}"
        elif self_power < other_power:
            return f"{other_dog.name} won the fight against {self.name}"
        else:
            return "It's a draw!"


# Step 2: Create Dog Instances
dog1 = Dog("Rex", 5, 20)
dog2 = Dog("Buddy", 3, 15)
dog3 = Dog("Max", 7, 30)

# Step 3: Test Dog Methods
print(dog1.bark())
print(f"{dog1.name}'s run speed: {dog1.run_speed():.2f}")
print(dog1.fight(dog2))

print(dog2.bark())
print(f"{dog2.name}'s run speed: {dog2.run_speed():.2f}")
print(dog2.fight(dog3))

print(dog3.bark())
print(f"{dog3.name}'s run speed: {dog3.run_speed():.2f}")
print(dog3.fight(dog1))

#3
# Step 1: Import the Dog class
# from dog_module import Dog  # если класс Dog в отдельном файле dog_module.py
# Для примера мы повторно определим Dog здесь

import random

class Dog:
    def __init__(self, name, age, weight):
        self.name = name
        self.age = age
        self.weight = weight

    def bark(self):
        return f"{self.name} is barking"

    def run_speed(self):
        return (self.weight / self.age) * 10

    def fight(self, other_dog):
        self_power = self.run_speed() * self.weight
        other_power = other_dog.run_speed() * other_dog.weight

        if self_power > other_power:
            return f"{self.name} won the fight against {other_dog.name}"
        elif self_power < other_power:
            return f"{other_dog.name} won the fight against {self.name}"
        else:
            return "It's a draw!"


# Step 2: Create the PetDog Class
class PetDog(Dog):
    def __init__(self, name, age, weight, trained=False):
        super().__init__(name, age, weight)
        self.trained = trained

    def train(self):
        print(self.bark())
        self.trained = True

    def play(self, *args):
        names = [dog.name for dog in args]
        names.append(self.name)
        print(f"{', '.join(names)} all play together")

    def do_a_trick(self):
        if self.trained:
            tricks = ["does a barrel roll", "stands on his back legs", "shakes your hand", "plays dead"]
            trick = random.choice(tricks)
            print(f"{self.name} {trick}")
        else:
            print(f"{self.name} is not trained yet.")


# Step 3: Test PetDog Methods
dog1 = PetDog("Rex", 5, 20)
dog2 = PetDog("Buddy", 3, 15)
dog3 = PetDog("Max", 7, 30)

# Train dog1 and dog2
dog1.train()
dog2.train()

# Dogs play together
dog1.play(dog2, dog3)

# Do a trick
dog1.do_a_trick()
dog2.do_a_trick()
dog3.do_a_trick()  # Not trained yet


#4
# Step 1: Create the Person Class
class Person:
    def __init__(self, first_name, age, last_name=""):
        self.first_name = first_name
        self.age = age
        self.last_name = last_name

    def is_18(self):
        return self.age >= 18


# Step 2: Create the Family Class
class Family:
    def __init__(self, last_name):
        self.last_name = last_name
        self.members = []

    def born(self, first_name, age):
        # Create a new Person object
        new_member = Person(first_name, age, self.last_name)
        # Add to members list
        self.members.append(new_member)

    def check_majority(self, first_name):
        # Search for member by first_name
        for member in self.members:
            if member.first_name == first_name:
                if member.is_18():
                    print(f"You are over 18, your parents Jane and John accept that you will go out with your friends")
                else:
                    print("Sorry, you are not allowed to go out with your friends.")
                return
        print("Member not found in the family.")

    def family_presentation(self):
        print(f"Family last name: {self.last_name}")
        print("Members:")
        for member in self.members:
            print(f"{member.first_name}, age {member.age}")


# --- Testing the classes ---
# Create a family
my_family = Family("Smith")

# Add members
my_family.born("Alice", 20)
my_family.born("Bob", 16)
my_family.born("Charlie", 25)

# Check majority
my_family.check_majority("Alice")   # Should allow
my_family.check_majority("Bob")     # Should not allow
my_family.check_majority("David")   # Member not found

# Show family presentation
my_family.family_presentation()
