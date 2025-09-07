# -----------------------------------------------
# Part 1 - Classes Human and Queue
# -----------------------------------------------

class Human:
    """
    Represents a citizen waiting for vaccination.
    Attributes:
        id_number (str) : unique identifier of the human
        name (str)      : person's name
        age (int)       : age in years
        priority (bool) : True if the person has medical priority
        blood_type (str): one of "A", "B", "AB", "O"
        family (list)   : humans living in the same house (Part 2)
    """
    def __init__(self, id_number, name, age, priority, blood_type):
        self.id_number = id_number
        self.name = name
        self.age = age
        self.priority = priority
        self.blood_type = blood_type
        self.family = []  # Part 2: start with empty family list

    def add_family_member(self, person):
        """
        Adds a family member both ways (mutual relation).
        Prevents duplicates.
        """
        if person not in self.family: #if person not already in family of the 1st person so we don't add duplicates
            self.family.append(person)# adds family member to family list of the 1st person
        if self not in person.family: # if self not already in the second person's family so we don't add duplicates
            person.family.append(self) # adds family member to person to family list of the 2nd person


class Queue:
    """
    Represents a queue of humans waiting for vaccination.
    Internally uses a list self.humans.
    """
    def __init__(self):
        self.humans = [] # starts with an empty list of humans

    def add_person(self, person):
        """
        Adds a human to the queue.
        If person is priority or older than 60, place them at the beginning.
        Otherwise, add at the end.
        """
        new_list = [] # temporary list to build the new order
        if person.priority or person.age > 60:
            # Place at beginning of temp list
            new_list.append(person)
            # Copy rest
            for h in self.humans:
                new_list.append(h)
            self.humans = new_list #copy back to self.humans
        else:
            # Place at end
            self.humans.append(person)

    def find_in_queue(self, person):
        """
        Returns the index of a person in the queue.
        Returns None if not found.
        """
        for i in range(len(self.humans)): # iterate through the list to find the person
            if self.humans[i] == person:
                return i
        return None

    def swap(self, person1, person2):
        """
        Swaps positions of two people in the queue.
        """
        idx1 = self.find_in_queue(person1)
        idx2 = self.find_in_queue(person2)
        if idx1 is not None and idx2 is not None:
            self.humans[idx1], self.humans[idx2] = self.humans[idx2], self.humans[idx1] #exchange indexes

    def get_next(self):
        """
        Returns and removes the next person in line (index 0).
        If queue is empty, return None.
        """
        if len(self.humans) == 0:
            return None
        # Remove first without using pop(0)
        next_person = self.humans[0]
        self.humans = [self.humans[i] for i in range(1, len(self.humans))] #remove first person by rebuilding list without index 0
        return next_person

    def get_next_blood_type(self, blood_type):
        """
        Returns and removes the first person with a given blood type.
        If not found, returns None.
        """
        for i in range(len(self.humans)):
            if self.humans[i].blood_type == blood_type:
                next_person = self.humans[i]
                # Rebuild list without this person
                self.humans = [self.humans[j] for j in range(len(self.humans)) if j != i]
                return next_person
        return None

    def sort_by_age(self):
        """
        Sorts humans by rules:
        1) Priority people first
        2) Then older (higher age first)
        3) Then younger
        Implemented manually (no list.sort / sorted).
        """
        # Manual bubble sort implementation
        n = len(self.humans)
        for i in range(n): #from 0 to the length of the list
            for j in range(0, n - i - 1):
                h1 = self.humans[j]
                h2 = self.humans[j + 1]

                # Define custom comparison
                def should_swap(a, b): # returns True if a should come after b
                    if a.priority and not b.priority:
                        return False  # a before b
                    if not a.priority and b.priority:
                        return True  # swap needed
                    if a.age < b.age:
                        return True  # older first
                    return False

                if should_swap(h1, h2):
                    self.humans[j], self.humans[j + 1] = self.humans[j + 1], self.humans[j]

    def rearrange_queue(self):
        """
        Rearranges queue so that no two family members stand together.
        Strategy:
        - Iterate through the queue.
        - If two consecutive members are from the same family, try to swap the second one with
          someone further down who is not in the family.
        """
        for i in range(len(self.humans) - 1): #until the second last person since they don't have a neighbor after them
            current = self.humans[i]
            next_person = self.humans[i + 1]

            if next_person in current.family: # in the family of the person being checked
                # Look ahead for someone not in the family
                for j in range(i + 2, len(self.humans)): #start with the third person after current
                    if self.humans[j] not in current.family:
                        # Swap them
                        self.humans[i + 1], self.humans[j] = self.humans[j], self.humans[i + 1]
                        break # break after first valid swap and continue with the next i


# -----------------------------------------------
# Example usage
# -----------------------------------------------
if __name__ == "__main__":
    # Create some people
    alice = Human("001", "Alice", 70, False, "A")
    bob = Human("002", "Bob", 30, True, "B")
    carol = Human("003", "Carol", 25, False, "O")
    dave = Human("004", "Dave", 40, False, "AB")

    # Add family relations
    alice.add_family_member(bob)

    # Create queue
    q = Queue()
    q.add_person(carol)
    q.add_person(alice)
    q.add_person(bob)
    q.add_person(dave)

    print("Initial queue:", [h.name for h in q.humans])

    q.sort_by_age()
    print("Sorted by age:", [h.name for h in q.humans])

    q.rearrange_queue()
    print("Rearranged queue:", [h.name for h in q.humans])

    # Get next
    next_person = q.get_next()
    print("Next vaccinated:", next_person.name)
    print("Remaining queue:", [h.name for h in q.humans])
