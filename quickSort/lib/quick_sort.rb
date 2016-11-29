class QuickSort

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)

  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)

  end

  def self.partition(array, start, length, &prc)
    prc = prc || proc {|el1, el2| el1 <=> el2}

    (start + 1 .. start + length).each do |idx|
      if prc.call(array[start], array[idx]) == 1
        array[start+1], array[idx] = array[idx], array[start+1]
        array[start], array[start+1] = array[start+1], array[start]
        start += 1
      end
    end

    start
  end
end
