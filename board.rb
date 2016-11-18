require_relative 'tile'

class Board
  attr_reader :grid

  def new_grid
    Array.new(9) do
      Array.new(9) { Tile.new }
    end
  end

  def initialize(grid = new_grid)
    @grid = grid
  end

  def render
    render_str = "  "
    (0...grid.length).each { |col| render_str << "#{col} "}
    render_str << "\n"
    grid.each_with_index do |row, idx|
      render_str << "#{idx} "
      row.each do |el|
        render_str << "#{el.to_str} "
      end
      render_str << "\n"
    end

    puts render_str.chomp
    puts "\n\n"
  end

  def populate
    count
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |el, el_idx|

      end

    end
  end

  def nearby_bombs(pos)
    counter = 0
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |el, el_idx|
        if adj?(row_idx, el_idx, pos) && el.bomb
          counter += 1
        end
      end

    end

    counter
  end

  def adj?(x, y, pos)
    return false if [x, y] == pos
    (x <= pos[0] + 1) &&
    (x >= pos[0] - 1) &&
    (y <= pos[1] + 1) &&
    (y >= pos[1] - 1)
  end

end




board = Board.new
#p board.grid
board.render
