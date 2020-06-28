# frozen_string_literal: true

module ThreeMensMorris
  class Game
    def initialize(x_player, o_player, board)
      @board = board
      @x_player = x_player
      @o_player = o_player
    end

    def play
      until (winner = @board.complete?)
        @board = x_player.move(@board)
        break if (winner = @board.complete?)

        @board = o_player.move(@board)
      end

      $stdout.puts @board
      $stdout.puts "winner: #{winner}"
    end

    private

    attr_reader :x_player, :o_player
  end
end
