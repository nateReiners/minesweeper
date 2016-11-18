class Tile
  attr_reader :bomb, :revealed

  def initialize(bomb = false)
    @bomb = bomb
    @revealed = false
  end

  def display_val
    if bomb
      "*"
    else
      "_"
    end
  end

  def to_str
    if @revealed
     display_val #properties: bomb, or blank(count: print if 1-8)
    else
     "X"
    end
  end

  def make_bomb
    @bomb = true
  end



end
