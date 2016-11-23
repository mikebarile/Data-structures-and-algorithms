require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  def [](index)
    raise 'index out of bounds' if index >= @length || index < 0
    @store[@start_idx + index]
  end

  def []=(index, val)
    raise 'index out of bounds' if index >= @length || index < 0
    @store[@start_idx + index] = value
  end

  def pop
    raise 'index out of bounds' if length == 0
    @length -= 1
    val = @store[length]
    @store[length] = nil
    val
  end

  def push(val)
    resize! if length == capacity
    @store[@length] = val
    @length += 1
  end

  def shift
    raise 'index out of bounds' if length == 0
    el = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx += 1
    @length -= 1
  end

  def unshift(val)
    resize! if length == capacity
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def resize!
    new_store = @capacity == 0 ? StaticArray.new(1) : StaticArray.new(@capacity * 2)
    i = 0
    while i < length
      new_store[i] = @store[i]
      i += 1
    end
    @capacity = @capacity == 0 ? 1 : @capacity * 2
    @store = new_store
  end
end
