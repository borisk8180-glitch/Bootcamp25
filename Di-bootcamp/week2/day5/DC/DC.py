import random  # We need the random module to shuffle the deck

# -------------------------
# CARD CLASS
# -------------------------
class Card:
    """
    Represents a single playing card.
    Each card has:
        - a suit (Hearts, Diamonds, Clubs, Spades)
        - a value (A, 2, 3, ..., 10, J, Q, K)
    """
    def __init__(self, suit, value):
        # Store the card's suit (string)
        self.suit = suit
        # Store the card's value (string)
        self.value = value

    def __repr__(self): # triggered for debugging and printing
        """
        This method controls how the object will be displayed when printed.
        Example: Card("Hearts", "A") --> "A of Hearts"
        """
        return f"{self.value} of {self.suit}"


# -------------------------
# DECK CLASS
# -------------------------
class Deck:
    """
    Represents a full deck of 52 playing cards.
    The Deck contains Card objects (created from the Card class).
    """

    def __init__(self):
        """
        Constructor method: automatically creates a full deck of 52 cards
        when a Deck object is initialized.
        """
        self.suits = ["Hearts", "Diamonds", "Clubs", "Spades"]  # 4 suits
        self.values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                       "J", "Q", "K"]  # 13 values
        self.cards = []  # Will store the actual deck of 52 Card objects
        self._create_deck()  # Call helper method to fill the deck

    def _create_deck(self):
        """
        Private helper method to create a full deck of 52 cards.
        It combines each suit with each value.
        """
        self.cards = [Card(suit, value) for suit in self.suits for value in self.values]
        #self.cards = [Card(suit, value) [for suit in self.suits] [for value in self.values]]
        #print(self.cards)

    def shuffle(self):
        """
        Shuffle the deck randomly.
        Important: Before shuffling, recreate the full deck to ensure it has all 52 cards.
        """
        self._create_deck()         # Reset to full deck of 52 cards
        random.shuffle(self.cards)  # Shuffle in-place using Python's built-in shuffle

    def deal(self):
        """
        Deal (remove and return) a single card from the deck.
        If the deck is empty, return None.
        """
        if len(self.cards) == 0:
            return None  # No cards left
        return self.cards.pop()  # Remove the last card from the list and return it
# Example usage:
# Create a new deck
deck = Deck()

# Shuffle the deck
deck.shuffle()

# Deal 5 cards
hand = [deck.deal() for _ in range(5)]
print("Your hand:", hand)

# Remaining cards in deck
print("Cards left in deck:", len(deck.cards))
