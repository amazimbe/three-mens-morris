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
      grid_size = grid.length
      main = (0...grid_size).map { |index| grid[index][index] }

      k = grid_size - 1
      other = (0...grid_size).map do |index|
        val = grid[index][k]
        k -= 1
        val
      end

      [main, other]
    end

    def colums
      col_count = rows[0].length
      (0...col_count).map do |i|
        rows.inject([]) { |col, row| col << row[i] }
      end
    end

    def self.square_to_index(square)
      row = square.gsub!(/([a-cA-C])/, '').to_i - 1
      col = Regexp.last_match(1).downcase.ord - 'a'.ord
      [row, col]
    end

    def self.index_to_square(row, col)
      "#{(col + 'a'.ord).chr}#{row + 1}"
    end
  end
end
