import math

# Step 1 & 2: Create Pagination class
class Pagination:
    def __init__(self, items=None, page_size=10):
        self.items = items if items is not None else []
        self.page_size = page_size
        self.current_idx = 0
        self.total_pages = math.ceil(len(self.items) / self.page_size) if self.items else 0

    # Step 3: Get visible items on current page
    def get_visible_items(self):
        start = self.current_idx * self.page_size
        end = start + self.page_size
        #print(f'начало: {start}, конец: {end}')
        return self.items[start:end]

    # Step 4: Navigation methods
    def go_to_page(self, page_num):
        if page_num < 1 or page_num > self.total_pages:
            raise ValueError(f"Page number {page_num} out of range. Total pages: {self.total_pages}")
        self.current_idx = page_num - 1

    def first_page(self):
        self.current_idx = 0
        return self

    def last_page(self):
        self.current_idx = self.total_pages - 1
        return self

    def next_page(self):
        if self.current_idx < self.total_pages - 1:
            self.current_idx += 1
        return self

    def previous_page(self):
        if self.current_idx > 0:
            self.current_idx -= 1
        return self

    # Step 5: Custom __str__ method
    def __str__(self):
        return "\n".join(self.get_visible_items())


# Step 6: Test the Pagination class
if __name__ == "__main__":
    alphabetList = list("abcdefghijklmnopqrstuvwxyz")
    p = Pagination(alphabetList, 4)

    print(p.get_visible_items())
    # ['a', 'b', 'c', 'd']

    p.next_page()
    print(p.get_visible_items())
    # ['e', 'f', 'g', 'h']

    p.last_page()
    print(p.get_visible_items())
    # ['y', 'z']

    p.go_to_page(7)
    print(p.current_idx + 1)
    # 7

    try:
        p.go_to_page(0)  # Raises ValueError
    except ValueError as e:
        print(e)
