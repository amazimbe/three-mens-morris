describe ThreeMensMorris::Board do
  subject(:board) { ThreeMensMorris::Board.new(grid) }

  let(:grid) do
    [['x','o','o'],
     ['x','o','x'],
     ['x','o','o']]
  end

  describe '#update' do
    before do
      board.update(0, 0, 'o')
    end

    let(:new_grid) do
      [['o','o','o'],
       ['x','o','x'],
       ['x','o','o']]
    end

    it 'updates the grid' do 
      expect(board.grid).to match_array new_grid
    end
  end

  describe '#colums' do
    let(:result) do
      [['x', 'x', 'x'],
       ['o', 'o', 'o'],
       ['o', 'x', 'o']]
    end

    it 'returns all colums on the board' do
      expect(board.colums).to match_array result 
    end
  end

  describe '#diagonals' do
    let(:result) do
      [['x', 'o', 'o'],
       ['o', 'o', 'x']]
    end

    it 'returns all diagonals on the board' do
      expect(board.diagonals).to match_array result 
    end
  end

  describe '#complete?' do
    context 'when one player has 3 in a row' do
      let(:grid) do
        [['o','o','o'],
         ['x','x','o'],
         ['x','o','*']]
      end
  
      it 'returns true' do
        expect(board.complete?).to eq 'o'
      end
    end

    context 'when one player has 3 in a column' do
      let(:grid) do
        [['*','o','*'],
         ['*','o','o'],
         ['*','o','*']]
      end
  
      it 'returns true' do
        expect(board.complete?).to eq 'o'
      end
    end

    context 'when one player has 3 in a diagonal' do
      let(:grid) do
        [['*','o','x'],
         ['*','x','o'],
         ['x','o','*']]
      end
  
      it 'returns true' do
        expect(board.complete?).to eq 'x'
      end
    end

    context 'when no player has 3 in a diagonal, row or column' do
      let(:grid) do
        [['*','*','*'],
         ['*','*','*'],
         ['*','*','*']]
      end
  
      it 'returns true' do
        expect(board.complete?).to be_nil
      end
    end
  end

  describe '#moves' do
    let(:grid) do
      [['*','*','*'],
       ['x','o','x'],
       ['*','o','*']]
    end

    it 'returns all valid moves' do
      expect(board.moves).to match_array %w[a1 a3 b1 c1 c3]
    end
  end

  describe '.index_to_square' do
    it 'returns the correct square name' do
      expect(described_class.index_to_square(0, 0)).to eq 'a1' 
      expect(described_class.index_to_square(2, 2)).to eq 'c3' 
      expect(described_class.index_to_square(1, 1)).to eq 'b2' 
    end
  end

  describe '.square_to_index' do
    it 'returns the correct index' do
      expect(described_class.square_to_index('a1')).to match_array [0, 0]
      expect(described_class.square_to_index('c3')).to match_array [2, 2]
      expect(described_class.square_to_index('b2')).to match_array [1, 1]
    end
  end

  describe '#to_s' do
    let(:expected_board) do
      "#{grid[0].join('-')}\n|\\|/|\n#{grid[1].join('-')}\n|\\|/|\n#{grid[2].join('-')}"
    end

    it 'returns a string representation of the board' do
      expect(board.to_s).to eq expected_board
    end
  end
end