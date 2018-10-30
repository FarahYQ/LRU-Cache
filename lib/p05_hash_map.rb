require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count + 1 > num_buckets
    if bucket(key).include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |buck|
      buck.each { |node| yield(node.key, node.val)}
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set


  def num_buckets
    @store.length
  end

  def resize!
    temp = @store
    @store = Array.new(num_buckets*2) {LinkedList.new}
    temp.each do |buck|
      buck.each do |node|
        bucket(node.key).append(node.key, node.val)
      end
    end
  end

  def bucket(key)
    num = key.hash
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
