require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  count = HashMap.new
  string.chars do |c|
    c_count = count.get(c) || 0
    count.set(c, c_count + 1)
  end
  evens = 0
  odds = 0
  count.each { |}
end

# "edified"
