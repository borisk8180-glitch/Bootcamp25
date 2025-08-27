# sample_dict = { 
#    "class":{ 
#       "student":{ 
#          "name":"Mike",
#          "marks":{ 
#             "physics":70,
#             "history":80
#          }
#       }
#    }
# }

# print(sample_dict["class"]["student"]["marks"]["physics"])

# import this

sample_dict = {
            "name": "Kelly",
            "age":25,
            "salary": 8000,
            "city": "New york"
            }
keys_to_remove = ["name", "salary"]
for key in keys_to_remove:
    sample_dict.pop(key)
print(sample_dict)


# student_info = {
#     'first_name': 'Harry',
#     'last_name': 'Potter',
#     'age': 14,
#     'address' : 'Privet Drive, 4',
#     'pets': ['Hedwig', 'Buckbeak'],
#     'houses': {'main': 'Griffyndor', 'second': 'Slytherin'},
#     'best_friends': ('Ron Weasley', 'Hermione Granger')
# }
# for key in student_info:
#     print(student_info[key])
# for item in student_info.values():
#     print(item)
# my_string = "hello world"
# for ind,letter in enumerate(my_string):
#     print(ind,letter)

#resut for item in list

