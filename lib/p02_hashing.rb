class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    h = 1
    self.each_with_index do |el, idx|
      next if !el.is_a?(Integer)
      h *= el*(idx+1) + (el+idx+1)
    end
    h
  end
end

class String
  def hash
    h = 1
    self.chars.each_with_index { |c, idx| h *= c.ord*(idx+1) + (c.ord + idx + 1)}
    h
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    h = 1
    self.each { |k,v| h *= k.hash * v.hash}
    h
  end
end
