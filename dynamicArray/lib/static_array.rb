# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(capacity)
    @store = []
    @capacity = capacity
  end

  # O(1)
  def [](index)
    if index >= @capacity
      raise 'index out of bounds'
    end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    if index >= @capacity
      raise 'index out of bounds'
    end
    @store[index] = value
  end

  protected
  attr_accessor :store
end
