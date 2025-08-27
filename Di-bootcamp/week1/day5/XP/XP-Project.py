# Tic-Tac-Toe Game

def create_board():
    return [[' ' for _ in range(3)] for _ in range(3)]

def display_board(board):
    print("  0   1   2")
    for idx, row in enumerate(board):
        print(idx, ' | '.join(row))
        if idx < 2:
            print("  ---------")

def player_input(board, player):
    while True:
        try:
            pos = input(f"Player {player}, enter your move as row,col (e.g., 1,2): ")
            row, col = map(int, pos.strip().split(','))
            if row not in range(3) or col not in range(3):
                print("Invalid position. Please enter row and column between 0 and 2.")
                continue
            if board[row][col] != ' ':
                print("Cell already taken. Choose another.")
                continue
            return row, col
        except (ValueError, IndexError):
            print("Invalid input format. Please enter as row,col (e.g., 1,2).")

def check_win(board, player):
    # Check rows and columns
    for i in range(3):
        if all(board[i][j] == player for j in range(3)):
            return True
        if all(board[j][i] == player for j in range(3)):
            return True
    # Check diagonals
    if all(board[i][i] == player for i in range(3)):
        return True
    if all(board[i][2-i] == player for i in range(3)):
        return True
    return False

def check_tie(board):
    return all(cell != ' ' for row in board for cell in row)

def play():
    board = create_board()
    current_player = 'X'
    while True:
        display_board(board)
        row, col = player_input(board, current_player)
        board[row][col] = current_player
        if check_win(board, current_player):
            display_board(board)
            print(f"Player {current_player} wins!")
            break
        if check_tie(board):
            display_board(board)
            print("It's a tie!")
            break
        current_player = 'O' if current_player == 'X' else 'X'

if __name__ == "__main__":
    play()