class Book
  attr_reader :length, :title, :author

  def initialize(args = {})
    @length = args[:length]
    @title  = args[:title]
    @author = args[:author]
  end

  def available?
    !checked_out?
  end

  def checkout
    @checked_out = true
  end

  def checked_out?
    @checked_out
  end

  def return
    @checked_out = false
  end

  def damaged?
    @damaged
  end

  def record_damage
    @damaged = true
  end

  def repair
    @damaged = false
  end
end
