require_relative "heap"

class Array
  def heap_sort!
    (2..self.length).each do |heap_sec|
      BinaryMinHeap.heapify_up(self, heap_sec - 1, heap_sec)
    end

    self.length.downto(2).each do |heap_sec|
      self[heap_sec - 1], self[0] = self[0], self[heap_sec - 1]
      BinaryMinHeap.heapify_down(self, 0, heap_sec - 1)
    end

    self.reverse!
  end
end
