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

      # need to fix this method!!!!
      board.reveal_all_adj(pos)
  end

  def run
    play_turn until won? || game_over?
    board.render
    if won?
      puts "You Win!"
    else
      puts "You lost!"
    end
  end


  def game_over?
    board.grid.each do |row|
      bombs = row.select { |el| el.bomb }
      return true if bombs.any? { |el| el.visible }
    end
    false
  end

  def won?
    board.grid.each do |row|
      non_bombs = row.reject { |el| el.bomb }
      return true if non_bombs.all? { |el| el.visible }
    end
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  x = Minesweeper.new
  x.run
end
