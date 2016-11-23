require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(capacity=0)
    @length = 0
    @capacity = capacity
    @arr = StaticArray.new(@capacity)
  end

  def [](index)
    @arr[index]
  end

  def []=(index, value)
    @arr[index] = value
  end

  def pop
    throw 'index out of bounds' if length == 0
    @length -= 1
    val = @arr[length]
    @arr[length] = nil
    val
  end

  def push(val)
    resize! if length == capacity
    @arr[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_arr = @capacity == 0 ? StaticArray.new(1) : StaticArray.new(@capacity * 2)
    i = 0
    while i < length
      new_arr[i] = @arr[i]
      i += 1
    end
    @capacity = @capacity == 0 ? 1 : @capacity * 2
    @arr = new_arr
  end
end
