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

    context 'when player enters an invalid move' do
      let(:first_prompt) do
        "Your turn #{player.label} (format: a1) "
      end

      let(:second_prompt) { 'Invalid move. Try again. '}

      it 'prompts for another move' do
        expect($stdout).to receive(:print).with(second_prompt)
        expect($stdout).to receive(:print).with(first_prompt)
        expect($stdin).to receive(:gets).and_return('a2', 'a1')

        player.move(board)

        expect(board.grid).to match_array new_grid
      end
    end
  end
end