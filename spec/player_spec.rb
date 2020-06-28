describe ThreeMensMorris::Player do
  subject(:player) { described_class.new('x') }
  let(:board) { ThreeMensMorris::Board.new(grid) }

  let(:grid) do
    [['*','*','*'],
     ['x','o','x'],
     ['*','o','*']]
  end

  describe '#move' do
    let(:new_grid) do
      [['x','*','*'],
       ['x','o','x'],
       ['*','o','*']]
    end

    it 'reads player input and updates board with move' do
      expect($stdout).to receive(:puts).with(board)
      expect($stdout).to receive(:print).with("Your turn #{player.label} (format: a1) ")
      expect($stdin).to receive(:gets).and_return('a1')
      
      player.move(board)

      expect(player.pieces.length).to be 2
      expect(board.grid).to match_array new_grid
    end

    context 'when players have used up all 3 pieces' do
      let(:grid) do
        [['*','x','*'],
         ['x','o','x'],
         ['*','o','o']]
      end

      let(:new_grid) do
        [['*','x','x'],
         ['x','o','*'],
         ['*','o','o']]
      end

      let(:prompt) { "Your turn #{player.label} (format: a1>a2) " }

      it 'moves pieces correctly' do
        expect(player).to receive(:pieces).twice.and_return([])
        expect($stdout).to receive(:print).with(prompt)
        expect($stdin).to receive(:gets).and_return('c2>c1')

        player.move(board)
        
        expect(board.grid).to match_array new_grid
      end
    end
  end
end