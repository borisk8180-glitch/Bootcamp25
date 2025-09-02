# # picture = [
# #    [0,0,0,1,0,0,0], 
# #    [0,0,1,1,1,0,0], 
# #    [0,1,1,1,1,1,0], 
# #    [1,1,1,1,1,1,1], 
# #    [0,0,0,1,0,0,0], 
# #    [0,0,0,1,0,0,0] 
# # ]
# # for row in picture:# Iterate through each row in the picture
# #     for pixel in row:# Iterate through each pixel in the row
# #         if pixel == 1:
# #             print('*', end='')# Print '*' for 1 while staying on the same line
# #         else:
# #             print(' ', end='')# Print space for 0 while staying on the same line
# #     print() # New line after each row
# import os
# dir_path = os.path.dirname(os.path.realpath(__file__))
# print(f"Current directory: {dir_path}")
# # with open(os.path.join(dir_path, "Starwars.txt"), "r") as f:
# #     for line in f:
# #         print(line.strip())
# #     lines = f.readlines()    
# #     print("end of file")
# #     print("\n5th line of the file:")
# #     print(lines[4].strip())

# with open(os.path.join(dir_path, "Starwars.txt"), "r") as f:

#     first_chars = f.readline(5)
#     print("\nFirst 5 characters of the file:")
#     print(first_chars)

# with open(os.path.join(dir_path, "Starwars.txt"), "r") as f:

#     lines = f.readlines()
  
#     # word_letters = [[list(word) for word in line.split()] for line in lines]
#     # print("\nList of words split into letters:")
#     # print(word_letters)
#     # print(lines.strip())

# # 7. Append "SkyWalker" next to each "Luke"
# with open(filename, "r") as f:
#     text = f.read()

# text = text.replace("Luke", "Luke SkyWalker")

# with open(filename, "w") as f:
#     f.write(text)

# print("\nReplaced 'Luke' with 'Luke SkyWalker' in the file.")

import json
import os   
dir_path = os.path.dirname(os.path.realpath(__file__))
with open(os.path.join(dir_path, "\\family.json"), "r") as f:
json.dump(myfamily, open(os.path.join(dir_path, "family.json"), "w"), indent=4)
    pass