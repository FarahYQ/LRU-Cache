require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count + 1 > num_buckets
    num = key.hash
    self[num].push(key)
    @count += 1
  end

  def include?(key)
    num = key.hash
    self[num].any? { |el| el == key }
  end

  def remove(key)
    num = key.hash
    self[num].delete(key)
    @count -= 1
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
    @store = Array.new(num_buckets*2) {Array.new}
    temp.each do |bucket|
      self[bucket[0]].push(bucket[0]) if bucket[0]
    end
  end
end
