require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(capacity=0)
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  def [](index)
    raise 'index out of bounds' if index >= @length || index < 0
    @store[index]
  end

  def []=(index, value)
    raise 'index out of bounds' if index >= @length || index < 0
    @store[index] = value
  end

  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    val = @store[@length]
    @store[@length] = nil
    val
  end

  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  def shift
    raise 'index out of bounds' if @length == 0
    new_store = StaticArray.new(@capacity)
    i = 0
    @length -= 1
    val = @store[0]
    while i < @length
      new_store[i] = @store[i+1]
      i += 1
    end
    @store = new_store
    val
  end

  def unshift(val)
    if @length == @capacity
      if @length == 0
        new_store = StaticArray.new(1)
        @capacity = 1
      else
        new_store = StaticArray.new(@capacity * 2)
        @capacity *= 2
      end
    else
      new_store = StaticArray.new(@capacity)
    end

    new_store[0] = val
    i = 0
    while i < @length
      new_store[i+1] = @store[i]
      i += 1
    end
    @length += 1
    @store = new_store
  end

  protected
  attr_accessor :store
  attr_accessor :capacity
  attr_writer :length

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_store = @capacity == 0 ? StaticArray.new(1) : StaticArray.new(@capacity * 2)
    i = 0
    while i < @length
      new_store[i] = @store[i]
      i += 1
    end
    @capacity = @capacity == 0 ? 1 : @capacity * 2
    @store = new_store
  end
end
