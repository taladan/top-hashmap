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
end
