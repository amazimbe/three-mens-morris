# frozen_string_literal: true

module ThreeMensMorris
  class Player
    attr_reader :label, :pieces

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
      $stdout.print "Your turn #{label} (format: #{move_format}) "
      move = $stdin.gets

      # until board.empty_squares.include?(move.chomp.downcase)
      #   $stdout.print 'Invalid move. Try again. '
      #   move = $stdin.gets
      # end

      move
    end

    def move_format
      pieces.empty? ? 'a1>a2' : 'a1'
    end
  end
end
