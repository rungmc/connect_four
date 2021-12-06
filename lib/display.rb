# frozen_string_literal: true

# Displays game on CLI.
module Display
  P1_TOKEN = "\u26aa"
  P2_TOKEN = "\u26ab"
  OPEN_SPACE = "\u3000"
  SEPARATOR = "\u250a"
  DIVIDER = ' +--+--+--+--+--+--+--+'

  def introduction
    puts
  end

  def draw_board(arr)
    # system "clear"
    printer = Array.new(arr[0].size, " #{SEPARATOR}")
    arr.each do |column|
      column.each_with_index { |token, index| printer[index] += "#{token}#{SEPARATOR}" }
    end
    puts
    printer.reverse.each { |row| puts row, DIVIDER }
    puts "  1  2  3  4  5  6  7\n\n"
  end
end
