require 'colorize'
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
      render_str << "#{idx}|"
      row.each_with_index do |el, el_idx|
        if el.visible
          if el.bomb
            render_str << "*".colorize(:color => :yellow, :background => :red) + "|"
          elsif nearby_bombs([idx, el_idx]) > 0
            render_str << colorize(nearby_bombs([idx, el_idx]))
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

  def colorize(num_nearby_bombs)
    colored_num_str = ""
    case num_nearby_bombs
    when 1
      colored_num_str = num_nearby_bombs.to_s.colorize(:blue) + "|"
    when 2
      colored_num_str = num_nearby_bombs.to_s.colorize(:yellow) + "|"
    when 3
      colored_num_str = num_nearby_bombs.to_s.colorize(:red) + "|"
    when 4
      colored_num_str = num_nearby_bombs.to_s.colorize(:red) + "|"
    end
    colored_num_str
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

  def reveal_all_adj(pos)
    grid.each_with_index do |row, r_idx|
      row.each_with_index do |el, el_idx|
        if adj?(r_idx, el_idx, pos)
          unless el.bomb
            el.visible = true
          end
        end
      end
    end
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
