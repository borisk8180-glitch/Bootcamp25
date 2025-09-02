import math

class Circle:
    def __init__(self, radius=None, diameter=None):
        """
        Initialize a Circle with either radius or diameter.
        If diameter is provided, radius is calculated.
        """
        if radius is not None:
            self.radius = radius
        elif diameter is not None:
            self.radius = diameter / 2
        else:
            raise ValueError("You must provide either radius or diameter.")
    
    @property
    def diameter(self):
        """Return the diameter of the circle."""
        return self.radius * 2

    def area(self):
        """Return the area of the circle."""
        return round(math.pi * self.radius ** 2)

    # Dunder method to print the circle
    def __str__(self):
        return f"Circle with radius: {self.radius:.2f}"

    def __repr__(self):
        return f"Circle(radius={self.radius:.2f})"

    # Dunder method to add two circles
    def __add__(self, other):
        if isinstance(other, Circle):
            return Circle(radius=self.radius + other.radius)
        return NotImplemented

    # Comparison dunder methods
    def __eq__(self, other):
        if isinstance(other, Circle):
            return self.radius == other.radius
        return NotImplemented

    def __lt__(self, other):
        if isinstance(other, Circle):
            return self.radius < other.radius
        return NotImplemented

    def __le__(self, other):
        if isinstance(other, Circle):
            return self.radius <= other.radius
        return NotImplemented

    def __gt__(self, other):
        if isinstance(other, Circle):
            return self.radius > other.radius
        return NotImplemented

    def __ge__(self, other):
        if isinstance(other, Circle):
            return self.radius >= other.radius
        return NotImplemented

# Example usage
c1 = Circle(radius=5)
c2 = Circle(diameter=10)

print(c1)               # Circle with radius: 5.00
print(c2.diameter)      # 10
print(f"Area of c1: {c1.area():.2f}")  # Area of c1: 78.54

# Adding circles
c3 = c1 + c2
print(c3)               # Circle with radius: 10.00

# Comparing circles
print(c1 > c2)          # False
print(c1 < c2)          # True
print(c1 == Circle(radius=5))  # True

# Sorting a list of circles
circle_list = [c2, c1, c3]
circle_list.sort()
print(circle_list)      # [Circle(radius=5.00), Circle(radius=5.00), Circle(radius=10.00)]
for c in circle_list:
    print(c)             # Circle with radius: 5.00
    print(c.diameter)    # 10
    print(f"Area of c: {c.area():.2f}")  # Area of c: 78.54
    print()               # New line for better readability
