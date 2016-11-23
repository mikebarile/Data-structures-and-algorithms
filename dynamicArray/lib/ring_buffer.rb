require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  def [](index)
    raise 'index out of bounds' if index >= @length || index < 0
    @store[(@start_idx + index) % @capacity]
  end

  def []=(index, val)
    raise 'index out of bounds' if index >= @length || index < 0
    @store[(@start_idx + index) % @capacity] = val
  end

  def pop
    raise 'index out of bounds' if @length == 0
    val = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    val
  end

  def push(val)
    resize! if @length == @capacity
    @length += 1
    self[@length - 1] = val
  end

  def shift
    raise 'index out of bounds' if @length == 0
    el = @store[@start_idx]
    @store[@start_idx] = nil

    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1

    el
  end

  def unshift(val)
    resize! if @length == @capacity

    @start_idx = (@start_idx - 1) % @capacity
    @length += 1
    @store[@start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def resize!
    new_capacity = @capacity == 0 ? 1 : @capacity * 2
    new_store = StaticArray.new(new_capacity)
    i = 0
    while i < @length
      new_store[i] = self[i]
      i += 1
    end
    @capacity = new_capacity
    @start_idx = 0
    @store = new_store
  end
end
