
class Point:
    color = 'red'
    circle = 2

    def __new__(cls, *args, **kwargs):
        print("call __new__" + str(cls))
        print(super().__new__(cls))

    def __init__(self,a,b):
        self.x = a
        self.y = b
    # def __del__(self):
    #     print("call __del__" + str(self))
    def set_coords(self,x,y):
        self.x = x
        self.y = y
    # print("call set_coords" + str(self))
    def get_coords(self):
        return self.x, self.y

pt = Point(10,20)
print(pt)

