# from datetime import datetime

# birthday_str = input("Enter your full birthday (YYYY-MM-DD): ")
# current_date = datetime.now()

# try:
#     birthday = datetime.strptime(birthday_str, "%Y-%m-%d")
#     age = current_date.year - birthday.year - ((current_date.month, current_date.day) < (birthday.month, birthday.day))
#     last_digit = age % 10
#     #print(f"The last digit of your age is: {last_digit}")
#     cake_width = 13
#     footing = int((cake_width - last_digit) /2)
#     space = "  "
#     print(space + "-" * footing + "i" * last_digit + "-" * footing)
#     print(space + '|:H:a:p:p:y:|')
#     print('__|___________|__')
#     print('|^^^^^^^^^^^^^^^^^|')
#     print('|:B:i:r:t:h:d:a:y:|')
#     print('|                 |')
#     print('~~~~~~~~~~~~~~~~~~~')

# except ValueError:
#     print("Please enter your birthday in the correct format (YYYY-MM-DD).")
import matplotlib.pyplot as plt
dev_x = list(range(23, 34))
print(dev_x)
dev_y = list(range(38496, 73752,3504))
print(dev_y)
plt.plot(dev_x, dev_y, marker='o', color='b', linestyle='--')
plt.title("Median Salary (USD) by Age") 
plt.xlabel("Ages")
plt.ylabel("Median Salary (USD)")   
plt.grid(True)
plt.xticks(dev_x)
plt.yticks(dev_y)
plt.show()# from datetime import datetime