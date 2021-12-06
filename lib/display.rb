# frozen_string_literal: true

# Displays game on CLI.
module Display
  P1_TOKEN = "\u26aa"
  P2_TOKEN = "\u26ab"
  OPEN_SPACE = "\u3000"
  SEPARATOR = "\u250a"
  DIVIDER = ' +--+--+--+--+--+--+--+'

  def introduction
    puts <<-TITLE
            =============================
            == C O N N E C T = F O U R ==
            =============================

Two players enter, one player... connects... four...
              Player 1: #{P1_TOKEN}, Player 2: #{P2_TOKEN}

Enter the number of the column you'd like to drop
your token into. Four in a row in any direction wins!

TITLE
  end

  def draw_board(arr)
    printer = Array.new(arr[0].size, " #{SEPARATOR}")
    arr.each do |column|
      column.each_with_index { |token, index| printer[index] += "#{token}#{SEPARATOR}" }
    end
    puts
    printer.reverse.each { |row| puts row, DIVIDER }
    puts "  1  2  3  4  5  6  7\n\n"
  end
end
