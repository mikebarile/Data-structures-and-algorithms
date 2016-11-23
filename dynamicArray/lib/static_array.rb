# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @store = []
    @length = length
  end

  # O(1)
  def [](index)
    if index >= @length
      raise 'index out of bounds'
    end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    if index >= @length
      raise 'index out of bounds'
    end
    @store[index] = value
  end

  protected
  attr_accessor :store
end
