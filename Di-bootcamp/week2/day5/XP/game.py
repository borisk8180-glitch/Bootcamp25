# game.py
import random

class Game:
    def get_user_item(self):
        """
        Ask the user to choose rock, paper, or scissors.
        Validate input and return the user's choice.
        """
        choice = input("Choose rock, paper, or scissors: ").strip().lower()
        while choice not in ["rock", "paper", "scissors"]:
            print("Invalid choice. Please type rock, paper, or scissors.")
            choice = input("Choose rock, paper, or scissors: ").strip().lower()
        return choice

    def get_computer_item(self):
        """
        Randomly choose rock, paper, or scissors for the computer.
        """
        return random.choice(["rock", "paper", "scissors"])

    def get_game_result(self, user_item, computer_item):
        """
        Determine the result of the game.
        Return 'win', 'loss', or 'draw'.
        """
        if user_item == computer_item:
            return "draw"

        # Rules of winning
        if (user_item == "rock" and computer_item == "scissors") or \
           (user_item == "scissors" and computer_item == "paper") or \
           (user_item == "paper" and computer_item == "rock"):
            return "win"
        else:
            return "loss"

    def play(self):
        """
        Play one round of Rock-Paper-Scissors.
        Show both choices and the result.
        Return the result as 'win', 'loss', or 'draw'.
        """
        user_item = self.get_user_item()
        computer_item = self.get_computer_item()
        result = self.get_game_result(user_item, computer_item)

        print(f"\nYou chose: {user_item}")
        print(f"Computer chose: {computer_item}")
        print(f"Result: You {result}!\n")

        return result