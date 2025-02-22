require 'pry'

class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, player = "X")
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index] == (" " || ""))
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    @board.count {|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets.chomp
    user_index = input_to_index(user_input)
    if valid_move?(user_index)
      move(user_index, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combo|
      if win_combo.all? {|win_index| @board[win_index] == "X"} || win_combo.all? {|win_index| @board[win_index] == "O"}
        return win_combo
      end
    end
    nil
  end

  def full?
    turn_count == 9
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    @board[won?[0]] if won?
  end

  def play
    puts "Welcome to Tic Tac Toe!"
    display_board
    turn until over?
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw?
  end

end

# game1 = TicTacToe.new
# game1.move(1, "X")
# game1.move(0, "X")
# game1.move(2, "X")
#
# game1.winner
