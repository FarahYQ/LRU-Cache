class MaxIntSet
  def initialize(max)
    @max = max
    @set = Array.new(@max, false)
  end

  def insert(num)
    is_valid?(num)
    @set[num] = true
  end

  def remove(num)
    is_valid?(num)
    @set[num] = false
  end

  def include?(num)
    is_valid?(num)
    @set[num] == true
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = 20
  end

  def insert(num)
    unless include?(num)
      self[num].push(num)
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? { |n| n == num }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count + 1 > num_buckets
    
    self[num].push(num)
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num][0] == num
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store
    @store = Array.new(num_buckets*2) { Array.new }
    temp.each do |bucket|
      self[bucket[0]].push(bucket[0]) if bucket[0]
    end
  end
end
