# frozen_string_literal: true

module ThreeMensMorris
  class Board
    attr_accessor :grid

    def initialize(grid)
      @grid = grid
    end

    def update(row, col, piece)
      grid[row][col] = piece
    end

    def moves
      moves = []
      rows.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          moves << Board.index_to_square(i, j) if cell == '*'
        end
      end
      moves
    end

    def complete?
      rows.each do |row|
        return 'x' if row.all? { |cell| cell == 'x' }
        return 'o' if row.all? { |cell| cell == 'o' }
      end

      colums.each do |col|
        return 'x' if col.all? { |cell| cell == 'x' }
        return 'o' if col.all? { |cell| cell == 'o' }
      end

      diagonals.each do |diag|
        return 'x' if diag.all? { |cell| cell == 'x' }
        return 'o' if diag.all? { |cell| cell == 'o' }
      end

      nil
    end

    def to_s
      rows.inject('') do |board, row|
        board + if board.empty?
                  row.join('-').to_s
                else
                  "\n|\\|/|\n#{row.join('-')}"
                 end
      end
    end

    alias rows grid

    def diagonals
      [
        [grid[0][0], grid[1][1], grid[2][2]],
        [grid[0][2], grid[1][1], grid[2][0]]
      ]
    end

    def colums
      cols = []

      (0..2).each do |i|
        cols << grid.map { |row| row[i] }
      end

      cols
    end

    def self.square_to_index(square)
      col = square.gsub!(/([a-cA-C])/, '').to_i - 1
      row = Regexp.last_match(1).downcase.ord - 'a'.ord
      [row, col]
    end

    def self.index_to_square(row, col)
      "#{(col + 'a'.ord).chr}#{row + 1}"
    end
  end
end
