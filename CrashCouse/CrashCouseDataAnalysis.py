#Exercises Python intro

first = "Hello world"
#This is a comment
print( "I AM A COMPUTER")

if 1 < 2 and 4 > 2:
    print("math is fun!")

nope = ""

print(11 > 3 and 12 < 30)

print(len("What is my length?"))

print("I am shouting".upper())

print(int('1000'))

print(str(4) + 'real')

print(3 * "cool") #coolcoolcool

print( 1 / 0) #Error div by 0

#list

name = input("Enter your name: ")

number = int(input("Enter a number: "))
if number < 0:
    print("That number is less than 0!")
elif number > 0:
    print ("That number is greater than 0!")
else:
    print("You picked 0!")  

print('Apple'.index('l'))

if 'xylophone'.index('y'):
    print('Found')

print('mystring'.lower())

#Cat and dog years

h_age = int(input("Enter your age: "))
if h_age <= 1:
    print(f"Cat & dog years = 15")
elif h_age == 2:
    print(f"Cat & dog years = {15+9}")
elif h_age>2:
    print(f"Cat years = {15+9+((h_age-2)*4)}")
    print(f"Dog years = {15+9+((h_age-2)*5)}")

