# linked_list.rb
require_relative 'node'

# lib/linked_list.rb
# create a linked list object
class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  # add item to end of list
  def append(key, value)
    # need to check if key is already included in LL, if so, overwrite value
    if include_key?(key)

      pos = find_key(key)
      at(pos).overwrite(value)
      return at(pos)
    end

    # otherwise check if list is empty, if so add k/v to head of list, if not, add to tail of list
    empty? ? set_head(key, value) : set_tail(key, value)
  end

  # add item to head of list
  def prepend(key, value)
    node = new_node(key, value)
    node.next_node = @head
    self.head = node
  end

  # return number of items in list
  def length
    return 0 if empty?

    count_node(@head, 1)
  end

  # return last item of list
  def tail
    last_node(@head)
  end

  # return item at `list[p]` position
  def at(position, node = @head, counter = 0)
    return nil if position > length
    return node if counter == position

    at(position, node.next_node, counter + 1)
  end

  # remove first item from list and return it
  def pop
    if @head.next_node.nil?
      node = @head
      @head = nil
      return node
    end
    new_tail = at(length - 2, @head)
    old_tail = new_tail.next_node
    new_tail.clear!
    old_tail
  end

  # boolean if list includes key
  def include_key?(key, node = @head)
    return false if empty?
    return true if node.key == key
    return false if node.tail?

    include_key?(key, node.next_node)
  end

  # boolean if list includes valeu
  def include_value?(value, node = @head)
    return true if node.value == value
    return false if node.tail?

    include_value?(value, node.next_node)
  end

  # locate position of key in list
  def find_key(key, node = @head, count = 0)
    return count if key == node.key
    return nil if node.tail?

    node = node.next_node
    find_key(key, node, count + 1)
  end

  # locate first position of value in list
  def find_value(value, node = @head, count = 0)
    return count if value == node.value
    return nil if node.tail?

    node = node.next_node
    find_value(value, node, count + 1)
  end

  # insert item at position
  def insert_at(key, value, position)
    node = Node.new(key, value)
    old_node = at(position)
    previous_node = at(position - 1) unless position == 0
    node.next_node = old_node
    previous_node.next_node = node unless position == 0
    node
  end

  # remove item by position
  def remove_at(position)
    node = at(position)
    previous_node = at(position - 1) unless position == 0
    previous_node.next_node = node.next_node unless position == 0
    node.clear!
    node
  end

  private

  # recursively count nodes
  def count_node(node, counter)
    return counter if node.tail?

    count_node(node.next_node, counter + 1)
  end

  # recursively find last node
  def last_node(node)
    return node if node.tail?

    last_node(node.next_node)
  end

  def set_head(key, value)
    self.head = Node.new(key, value)
  end

  def set_tail(key, value)
    last_node(@head).next_node = Node.new(key, value)
  end

  def empty?
    @head.nil?
  end
end
