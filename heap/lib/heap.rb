class BinaryMinHeap
  def initialize(&prc)
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
  attr_accessor :prc, :store

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
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
