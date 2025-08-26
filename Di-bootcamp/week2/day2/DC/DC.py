MATRIX_STR = '''
7ir
Tsi
h%x
i ?
sM# 
$a 
#t%'''

# Step 1: Transform the string into a 2D list (matrix)
matrix = [list(row) for row in MATRIX_STR.strip().split('\n')]# remove whitespace and split into rows
print(matrix)

# Step 2: Read column by column, top to bottom, left to right
num_matrix = len(matrix)#find number of rows
num_cols = len(matrix[0])#find number of columns

decoded_chars = []#list to hold decoded characters

for col in range(num_cols):#take each column
    for row in range(num_matrix):#populate list with characters from each row in that column
        if matrix[row][col].isalpha():#check if character is alpha
            decoded_chars.append(matrix[row][col])#append character to list
        else:
            decoded_chars.append(' ')#append space to list
print(decoded_chars)
# convert list of characters to string
decoded_str = ''.join(decoded_chars)
# Step 3: Replace multiple spaces with a single space
#print(decoded_str)
cleaned_str = decoded_str.split()#split into list of words to remove extra spaces
print(cleaned_str)
cleaned_str = ' '.join(cleaned_str)#join list of words back into a single string
#join method is called on ceparator ' ' (single space) to join the words back into a single string
print(cleaned_str)