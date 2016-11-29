class BinaryMinHeap
  def initialize(&prc)
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
    @store = []
  end

  def count
    @store.length
  end

  def extract
    raise 'no elements' if count == 0
    val = @store[0]

    if count > 1
      @store[0] = @store.pop
      BinaryMinHeap.heapify_down(@store, 0, &@prc)
    else
      store.pop
    end
  end

  def peek
    raise 'no elements' if count == 0
    store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, &@prc)
  end

  protected
  attr_accessor :store

  public
  def self.child_indices(len, parent_index)
    indices = []
    indices.push(parent_index * 2 + 1) if parent_index * 2 + 1 < len
    indices.push(parent_index * 2 + 2) if parent_index * 2 + 2 < len
    indices
  end

  def self.parent_index(child_index)
    if child_index == 0
      raise 'root has no parent'
    end

    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    child1, child2 = child_indices(len, parent_idx)
    parent_val = array[parent_idx]

    children = []
    children << array[child1] if child1
    children << array[child2] if child2

    if children.all? { |child| prc.call(parent_val, child) <= 0 }
      return array
    end

    smallest = nil
    if children.length == 1
      smallest = child1
    else
      smallest = prc.call(children[0], children[1]) == -1 ? child1 : child2
    end

    swap!(array, parent_idx, smallest)
    heapify_down(array, smallest, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    i = child_idx
    while i >= 1
      parent = parent_index(i)
      if prc.call(array[i], array[parent]) <= 0
        swap!(array, i, parent)
        i = parent
      else
        break
      end
    end
    return array
  end

  def self.swap!(array, idx1, idx2)
    array[idx1], array[idx2] = array[idx2], array[idx1]
  end
end
