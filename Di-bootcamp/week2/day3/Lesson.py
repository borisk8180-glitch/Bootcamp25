#Decorators are python built-in functions that we "apply" to our functions within the class, i.e methods
from datetime import datetime, date

class Person:

    def __init__(self, first_name, last_name, birth_date):
        self.first_name = self.format_name(first_name)
        self.last_name = self.format_name(last_name)
        self.birth_date = self.parse_birthdate(birth_date)
        self._email = None #protected attribute - the underscore here is a convension in python #this practice is called encapsulation
    
    @staticmethod  #a method that don't really needs the self
    def format_name(name):
        return name.capitalize()
    
    @staticmethod
    def parse_birthdate(date_str):
        return datetime.strptime(date_str, '%d-%m-%Y').date()
    
    @classmethod
    def from_age(cls, first_name, last_name, age:int):
        current_year = datetime.today().year
        birth_year = current_year - age
        birth_date = f'1-01-{birth_year}'
        return cls(first_name, last_name, birth_date)
    
    @property
    def age(self):
        today = date.today()
        age = today.year - self.birth_date.year
        return age
    
    @property
    def email(self):
        initial = self.first_name[0].lower()
        email = f'{initial}.{self.last_name.replace(" ", ".").lower()}@gmail.com'
        return email
    

p1 = Person('jhon', 'snow da silva', '21-08-1990')
print(p1.birth_date)
print(p1.first_name)
print(p1.birth_date)
print(p1.age)
print(p1.email)
p1.email = 'the choosen'
print(p1.email)

#how to use a class method when creating the object:
p2 = Person.from_age('aria', 'stark', 18)
print(p2.birth_date)
print(p2.email)

#search for options of #@property
# setter (p1.email = 'the choosen' and the output will be 'the.choosen@gmail.com')
# getter help you to retrieve the value
# deleter del p1.email

#create a property method that generates an gmail with initial of the first name. a dot and last name complete
# print(p1.email)
# output: j.snow@gmail.com





class Person:
    def __init__(self, first_name, last_name):
        self.first_name = first_name
        self.last_name = last_name

    @property
    def gmail(self):
        # Take the first letter of first_name + '.' + last_name
        return f"{self.first_name[0].lower()}.{self.last_name.lower()}@gmail.com"


# Example usage
person = Person("John", "Snow")
print(person.gmail)  