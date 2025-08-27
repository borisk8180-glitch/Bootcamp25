picture = [
   [0,0,0,1,0,0,0], 
   [0,0,1,1,1,0,0], 
   [0,1,1,1,1,1,0], 
   [1,1,1,1,1,1,1], 
   [0,0,0,1,0,0,0], 
   [0,0,0,1,0,0,0] 
]
for row in picture:# Iterate through each row in the picture
    for pixel in row:# Iterate through each pixel in the row
        if pixel == 1:
            print('*', end='')# Print '*' for 1 while staying on the same line
        else:
            print(' ', end='')# Print space for 0 while staying on the same line
    print() # New line after each row

    