# node.rb

class Node
  attr_reader :key
  attr_accessor :next_node, :value

  def initialize(key, value)
    @next_node = nil
    @key = key
    @value = value
  end

  def tail?
    @next_node.nil?
  end

  def clear!
    self.next_node = nil
  end

  def overwrite(value)
    @value = value
  end
end
