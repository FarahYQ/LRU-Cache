class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    count = 0
    each_with_index { |node,j| return node if i == j}
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    current = @head.next
    until current.next == nil
      return current.val if current.key == key
      current = current.next
    end
  end

  def include?(key)
    current = @head.next
    until current.next == nil
      return true if current.key == key
      current = current.next
    end
    return false
  end

  def append(key, val)
    new = Node.new(key,val)
    new.prev = @tail.prev
    new.next = @tail
    @tail.prev.next = new
    @tail.prev = new
  end

  def update(key, val)
    current = @head.next
    until current.next == nil
      if current.key == key
        current.val = val
        return
      end
      current = current.next
    end
  end

  def remove(key)
    current = @head.next
    until current.next == nil
      if current.key == key
        current.remove
        return
      end
      current = current.next
    end
  end

  def each
    current = @head.next
    until current.next == nil
      yield(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
