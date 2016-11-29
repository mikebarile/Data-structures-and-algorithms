class BinaryMinHeap
  def initialize(&prc)
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
    @store = []
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
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
    children = []
    children << array[child1] if array[child1]
    children << array[child2] if array[child2]
    if children.all? { |child| prc.call(array[parent_idx], child) <= 0}
      return array
    end

    i = parent_idx
    while i <= parent_index(len - 1)
      child1, child2 = child_indices(len, i)
      children = []
      children << array[child1] if array[child1]
      children << array[child2] if array[child2]
      if children.length == 1
        smallest = child1
      elsif children.length == 0
        break
      else
        smallest = prc.call(child1, child2) == -1 ? child1 : child2
      end

      if prc.call(array[i], array[smallest]) >= 0
        swap!(array, i, smallest)
        i = smallest
      else
        break
      end
    end
    heapify_down(array, parent_idx, len, &prc)
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
