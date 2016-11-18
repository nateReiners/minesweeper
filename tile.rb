require_relative 'board'

class Tile
  attr_reader :bomb, :revealed

  def initialize(bomb = false)
    @bomb = bomb
    @revealed = true
  end

  def display_val
    return "*" if bomb

  end

  def to_str
    if @revealed
     display_val #properties: bomb, or blank(count: print if 1-8)
    else
     "X"
    end
  end

  def flag

  end

  

end
