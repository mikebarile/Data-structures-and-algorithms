class QuickSort

  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc = prc || proc {|el1, el2| el1 <=> el2}

    return array if length < 2

    new_idx = partition(array, start, length, &prc)

    left_length = new_idx - start
    right_length = length - (left_length + 1)
    sort2!(array, start, left_length, &prc)
    sort2!(array, new_idx + 1, right_length, &prc)

    array
  end

  protected

  def self.partition(array, start, length, &prc)
    prc = prc || proc {|el1, el2| el1 <=> el2}

    (start + 1 ... start + length).each do |idx|
      if prc.call(array[start], array[idx]) == 1
        array[start+1], array[idx] = array[idx], array[start+1]
        array[start], array[start+1] = array[start+1], array[start]
        start += 1
      end
    end

    start
  end
end
