# frozen_string_literal: true

require './lib/display'

# Runs a game of Connect Four.
class ConnectFour
  include Display

  def initialize(board = init_board, player1 = 'Player 1', player2 = 'Player 2')
    @board = board
    @player1 = player1
    @player2 = player2
    @current_turn = @player1
  end

  def init_board
    Array.new(7) { Array.new(6) { OPEN_SPACE } }
  end

  def menu
    introduction
  end

  def play
    loop do
      draw_board(@board)
      player_input
      break if won? || full?

      player_turn
    end
    draw_board(@board)
    declare_victor
    play_again
  end

  def player_input
    input = ''
    loop do
      puts "#{@current_turn} - choose a column (1-7):"
      input = gets.chomp
      break if valid_play?(input)

      puts 'Invalid input!'
    end
    to_board(input.to_i - 1)
  end

  # Checks if input matches to a column number and there is at least one playable space.
  def valid_play?(input)
    return false unless input.size == 1

    input.match?(/[1-7]/) && @board[input.to_i - 1].last == OPEN_SPACE
  end

  # Adds player token to first available open space on the board.
  def to_board(input)
    @board[input][@board[input].find_index(OPEN_SPACE)] = player_token
  end

  def won?
    # Vert win || Horiz win || Diag win
    return true if match_four?(@board) || match_four?(@board.transpose) || match_four?(diags)

    false
  end

  # Flips whole board to keep operations simple/consistent for each diagonal direction.
  def diags
    build_diag(0, 3, @board) + build_diag(0, 3, @board.reverse) +
      build_diag(1, 2, @board.transpose) + build_diag(1, 2, @board.reverse.transpose)
  end

  def build_diag(start, stop, arr)
    diag_arr = []
    for i in start..stop
      count = 0
      line = []
      while count.between?(0, arr[0].size - 1) && (i + count).between?(0, arr.size - 1)
        line << arr[i + count][count]
        count += 1
      end
      diag_arr << line
    end
    diag_arr
  end

  def match_four?(arr)
    token = player_token
    arr.each { |i| return true if i in [*, ^token, ^token, ^token, ^token, *] }
    false
  end

  def full?
    @board.none? { |col| col.any?(OPEN_SPACE) }
  end

  # Changes turns from one player to the other.
  def player_turn
    @current_turn = @current_turn == @player1 ? @player2 : @player1
  end

  def player_token
    return P1_TOKEN if @current_turn == @player1

    P2_TOKEN
  end

  def declare_victor
    return puts "#{@current_turn} wins!" if won?

    puts 'Game ends in a draw!'
  end

  def play_again
    input = ''
    loop do
      puts 'Would you like to play again (y/n)?'
      input = gets.chomp
      break if input[0].match?(/[nyNY]/)

      puts 'Error! Must answer yes or no.'
    end
    quit if input[0].match?(/[nN]/)

    @board = init_board
    play
  end

  def quit
    puts 'Thanks for playing!'
    exit
  end
end
