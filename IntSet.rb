


class MaxIntSet

  attr_accessor :store

  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    raise "Num too large" if num > max

    store[num] = true
  end

  def remove
  end

  def include?
  end


end
