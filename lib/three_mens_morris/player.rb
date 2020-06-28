# frozen_string_literal: true

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

    def update_board(board, square)
      return if pieces.empty?

      row, col = Board.square_to_index(square)
      board.update(row, col, pieces.pop)
      board
    end

    def get_move(board)
      $stdout.puts board
      moves = board.moves
      $stdout.print "Your turn #{label} (format: a1) "
      move = $stdin.gets

      until moves.include?(move.chomp.downcase)
        $stdout.print 'Invalid move. Try again. '
        move = $stdin.gets
      end

      move
    end
  end
end
