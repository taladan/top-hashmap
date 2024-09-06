# frozen_string_literal: true

require_relative 'linked_list'

# lib/bucket.rb
# acts as a container for hash_map to store values
class Bucket
  attr_reader :id
  attr_accessor :contents

  def initialize(hash_code)
    @id = hash_code

    # Values are stored in a linked list to avoid collisions
    @contents = LinkedList.new
  end

  # return array of keys contained in bucket contents
  def keys(current_node = @contents.head, arr = [])
    arr << current_node.key
    return arr.flatten if current_node.next_node.nil?

    current_node = current_node.next_node
    keys(current_node, arr)
  end

  # return array of values contained in bucket contents
  def values(current_node = @contents.head, arr = [])
    arr << current_node.value
    return arr.flatten if current_node.next_node.nil?

    current_node = current_node.next_node
    values(current_node, arr)
  end
end
