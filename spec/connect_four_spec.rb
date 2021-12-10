# frozen_string_literal: true

require_relative '../lib/connect_four.rb'

describe ConnectFour do
  describe "#init_board" do
    subject(:gameboard) { described_class.new }

    context 'when called' do
      it 'creates a 7x6 board' do
        expect(gameboard.board.size).to be(7)
        gameboard.board.each { |row| expect(row.size).to be(6) }
      end
      it 'is filled with formatted blank spaces' do
        gameboard.board.each do |row|
          row.each { |val| expect(val).to be("\u3000") }
        end
      end
    end
  end

  describe '#valid_play?' do
    subject(:gameboard) { described_class.new }

    context 'when given a number between 1 and 7' do
      it 'returns true' do
        expect(gameboard.valid_play?("6")).to be_truthy
      end
    end

    context 'when given a number outside of 1 and 7' do
      it 'returns false' do
        expect(gameboard.valid_play?("9")).to be_falsey
      end
    end

    context 'when given non-integer input' do
      it 'returns false' do
        expect(gameboard.valid_play?("a")).to be_falsey
      end
    end

    context 'when given multi-char input' do
      it 'returns false' do
        expect(gameboard.valid_play?("9atfdsj234")).to be_falsey
      end
    end
  end

  describe '#won?' do
    subject(:gameboard) { described_class.new }

    context 'when board is not won (e.g., empty)' do
      it 'returns false' do
        expect(gameboard.won?).to be_falsey
      end
    end

    context 'when board has four consecutive horizontal tokens' do
      it 'returns true' do
        gameboard.board[0][1] = "\u26aa"
        gameboard.board[0][2] = "\u26aa"
        gameboard.board[0][3] = "\u26aa"
        gameboard.board[0][4] = "\u26aa"
        expect(gameboard.won?).to be_truthy
      end
    end

    context 'when board has four consecutive vertical tokens' do
      it 'returns true' do
        gameboard.board[1][5] = "\u26aa"
        gameboard.board[2][5] = "\u26aa"
        gameboard.board[3][5] = "\u26aa"
        gameboard.board[4][5] = "\u26aa"
        expect(gameboard.won?).to be_truthy
      end
    end

    context 'when board has top-down diagonal' do
      it 'returns true' do
        gameboard.board[0][4] = "\u26aa"
        gameboard.board[1][3] = "\u26aa"
        gameboard.board[2][2] = "\u26aa"
        gameboard.board[3][1] = "\u26aa"
        expect(gameboard.won?).to be_truthy
      end
    end

    context 'when board has bottom-up diagonal' do
      it 'returns true' do
        gameboard.board[0][0] = "\u26aa"
        gameboard.board[1][1] = "\u26aa"
        gameboard.board[2][2] = "\u26aa"
        gameboard.board[3][3] = "\u26aa"
        expect(gameboard.won?).to be_truthy
      end
    end
  end

  describe '#full?' do
    subject(:gameboard) { described_class.new }

    context 'when board has an open space' do
      it 'returns false' do
        expect(gameboard.full?).to be_falsey
      end
    end

    context 'when board has no open spaces' do
      it 'returns true' do
        gameboard.board = Array.new(7, Array.new(6, 'full!'))
        expect(gameboard.full?).to be_truthy
      end
    end
  end

  describe '#player_turn' do
    subject(:gameboard) { described_class.new }

    context 'after the first turn (player 1s)' do
      it 'changes turn to player 2' do
        gameboard.player_turn
        expect(gameboard.current_turn).to be('Player 2')
      end
    end

    context 'after the second turn (player 2s)' do
      it 'changes turn to player 1' do
        2.times { gameboard.player_turn }
        expect(gameboard.current_turn).to be('Player 1')
      end
    end
  end

  describe '#build_diag' do
    subject(:gameboard) { described_class.new }
    let(:arr) { [[1,2,3],[4,5,6],[7,8,9]] }
    let(:diags) { [[1,5,9],[4,8],[7]] }

    context 'when fed a 2D array' do
      it 'returns an array of diagonal lines across the board' do
        expect(gameboard.build_diag(0, 2, arr)).to eq(diags)
      end
    end
  end
end
