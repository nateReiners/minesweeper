class Tile
  attr_reader :bomb, :visible

  def initialize(bomb = false)
    @bomb = bomb
    @visible = false
  end

  def display_val
    if bomb
      "*"
    else
      "_"
    end
  end

  def to_str
    if visible
     display_val
   else
     "X"
   end
  end

  def make_bomb
    @bomb = true
  end

  def make_visible
    @visible = true
  end



end
