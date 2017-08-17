class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
  end

  def extract
    len = @store.length
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, len, &prc)
    val
  end

  def peek
  end

  def push(val)
    @store << val
    len = @store.length
    BinaryMinHeap.heapify_up(@store, len-1, len, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    if len >= 2*parent_index + 3
      return [2*parent_index + 1, 2*parent_index + 2]
    elsif len == 2*parent_index + 2
      return [2*parent_index + 1]
    else
      return []
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    i = parent_idx
    parent = array[i]
    child_1 = array[2*i + 1]
    child_2 = array[2*i + 2]
    prc = prc || Proc.new{ |a,b| a <=> b}
    # debugger
    until child_1.nil? && child_2.nil?
          if child_2.nil? && prc.call(parent, child_1) == 1
            array[2*i + 1], array[i] = array[i], array[2*i + 1]
          elsif prc.call(parent,child_1) == 1  || prc.call(parent,child_2) == 1
            if prc.call(child_2, child_1) == 1
              array[2*i + 1], array[i] = array[i], array[2*i + 1]
            else
              array[2*i + 2], array[i] = array[i], array[2*i + 2]
            end
        end
      i += 1
      parent = array[i]
      child_1 = array[2*i + 1]
      child_2 = array[2*i + 2]
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    i = child_idx
    child = array[i]
    parent = array[(i-1)/2]
    prc = prc || Proc.new{ |a,b| a <=> b}
    until i == 0
      if prc.call(parent, child) == 1
        array[i], array[(i-1)/2] = array[(i-1)/2], array[i]
        i = (i-1)/2
        child = array[i]
        parent = array[(i-1)/2]
      else
        break
      end
    end
    array
  end
end
