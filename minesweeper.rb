require_relative 'board'

class Minesweeper
attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def valid_move?(pos)
    pos.is_a?(Array) &&
    pos.length == 2 &&
    !board.grid[pos[0]][pos[1]].visible
  end

  def make_move(pos)
    board.grid[pos[0]][pos[1]].make_visible
  end

  def play_turn
    board.render
    pos = nil
    until valid_move?(pos)
      puts "enter coordinates as 'x,y' to 'click' a square"
      pos = gets.chomp.split(",").map(&:to_i)
    end
      make_move(pos)
  end

  def run
    play_turn until won?
  end

  def won?
    board.grid.each do |row|
      if row.all? { |el| el.visible }
        return true
      end
    end
    false
  end

end


x = Minesweeper.new
x.run
