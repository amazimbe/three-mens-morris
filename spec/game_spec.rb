RSpec.describe ThreeMensMorris::Game do
  let(:x_player) { ThreeMensMorris::Player.new('x') }
  let(:o_player) { ThreeMensMorris::Player.new('o') }
  let(:board_1)  { ThreeMensMorris::Board.new([%w[x o *], %w[x * *], %w[* o *]]) }
  let(:board_2)  { ThreeMensMorris::Board.new([%w[x o x], %w[x * *], %w[* o *]]) }
  let(:board_3)  { ThreeMensMorris::Board.new([%w[x o x], %w[x o *], %w[* o *]]) }
  let(:game) { ThreeMensMorris::Game.new(x_player, o_player, board_1) }

  describe '#play' do
    it 'iterates giving turns to both players until the game finishes' do
      expect(x_player).to receive(:move).with(board_1).and_return(board_2)
      expect(o_player).to receive(:move).with(board_2).and_return(board_3)
      expect($stdout).to receive(:puts).with(board_3)
      expect($stdout).to receive(:puts).with('winner: o')

      game.play
    end
  end
end