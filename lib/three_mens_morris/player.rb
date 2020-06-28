# frozen_string_literal: true
require 'byebug'
module ThreeMensMorris
  class Player
    attr_accessor :label, :pieces

    def initialize(label, piece_count = 3)
      @label = label
      @pieces = [label] * piece_count
    end

    def move(board)
      update_board(board, get_move(board))
    end

    private

    def update_board(board, move)
      if pieces.any?
        row, col = Board.square_to_index(move)
        board.update(row, col, pieces.pop)
      else
        start_at, end_at = move.split('>')
        row, col = Board.square_to_index(start_at)
        board.update(row, col, '*')

        row, col = Board.square_to_index(end_at)
        board.update(row, col, label)
      end
      
      board
    end

    def get_move(board)
      $stdout.puts board
      $stdout.print "Your turn #{label} (format: a1) "
      move = $stdin.gets

      until board.empty_squares.include?(move.chomp.downcase)
        $stdout.print 'Invalid move. Try again. '
        move = $stdin.gets
      end

      move
    end
  end
end
