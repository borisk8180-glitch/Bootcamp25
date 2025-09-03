# rock-paper-scissors.py
from game import Game

def get_user_menu_choice():
    """
    Show menu and get a valid choice from the user.
    """
    menu = """
    === Rock Paper Scissors ===
    1. Play a new game
    2. Show scores
    3. Quit
    """
    print(menu)

    choice = input("Enter your choice (1/2/3): ").strip()
    while choice not in ["1", "2", "3"]:
        print("Invalid choice. Please enter 1, 2, or 3.")
        choice = input("Enter your choice (1/2/3): ").strip()
    return choice


def print_results(results):
    """
    Display the final scores in a friendly format.
    """
    print("\n--- Game Summary ---")
    print(f"Wins: {results.get('win', 0)}")
    print(f"Losses: {results.get('loss', 0)}")
    print(f"Draws: {results.get('draw', 0)}")
    print("\nThank you for playing! Goodbye.")


def main():
    """
    Main loop of the program.
    """
    results = {"win": 0, "loss": 0, "draw": 0}

    while True:
        choice = get_user_menu_choice()

        if choice == "1":
            game = Game()
            outcome = game.play()
            results[outcome] += 1

        elif choice == "2":
            print_results(results)

        elif choice == "3":
            print_results(results)
            break


if __name__ == "__main__":
    main()