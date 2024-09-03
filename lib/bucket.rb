# frozen_string_literal: true

require_relative 'linked_list'

# lib/bucket.rb
# acts as a container for hash_map
class Bucket
  attr_reader :label
  attr_accessor :contents

  def initialize(hash_code)
    @label = hash_code
    @contents = LinkedList.new
  end
end
