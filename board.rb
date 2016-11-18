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

    populate_with_bombs
  end

  def render
    render_str = "  "
    (0...grid.length).each { |col| render_str << "#{col} "}
    render_str << "\n"
    grid.each_with_index do |row, idx|
      render_str << "#{idx} "
      row.each_with_index do |el, el_idx|
        if el.visible
          if el.bomb
            render_str << "*|"
          elsif nearby_bombs([idx, el_idx]) > 0
            render_str << "#{nearby_bombs([idx, el_idx])}|"
          else
            render_str << "#{el.to_str}|"
          end
        else
          render_str << "X|"
        end
      end
      render_str << "\n"
    end

    puts render_str.chomp
    puts "\n\n"
  end

  def populate_with_bombs
    bomb_locs = []
    until bomb_locs.length == 10
      x = (0..grid.length).to_a.sample
      y = (0...grid.length).to_a.sample
      rand_pos = [x, y]
      bomb_locs << rand_pos unless bomb_locs.include?(rand_pos)
    end

    @grid.each_with_index do |row, r_idx|
      row.each_with_index do |el, el_idx|
        if bomb_locs.include?([r_idx, el_idx])
          el.make_bomb
        end
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

# x = Board.new
# x.populate_with_bombs
# x.render
