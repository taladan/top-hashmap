# frozen_string_literal: true

require_relative 'bucket'
require_relative 'hasher'

# lib/hashmap.rb
class Hashmap
  attr_reader :buckets

  def initialize
    @capacity = 16
    @load_factor = 0.789
    @buckets = Array.new(@capacity)
    @hasher = Hasher.new
  end

  # set value to key
  def set(key, value)
    grow if @buckets.length == @capacity * @load_factor
    hsh = @hasher.make_hash(key)
    index = index_from_hash(hsh)

    # this feels kludgy
    @buckets[index].nil? ? new_bucket(hsh, index, key, value) : @buckets[index].contents.append(key, value)
  end

  # return value for key
  def get(key)
    raise KeyError if @buckets.empty?

    # get logic
    @buckets.each { |bucket| return bucket if bucket.id == @hasher.make_hash(key).hash }
    # container.contents.at(container.contents.find(key)) || raise KeyError
  end

  # boolean if has key in hashmap
  def has?(key)
    false if @buckets.empty?
    @hasher.make_hash(key)
    @buckets.each do |bucket|
      next if bucket.nil?
      return true if bucket.contents.include_key?(key)
    end
    false
  end

  # remove key from hash and return deleted entry's value
  def remove(_key)
    raise KeyError if @buckets.empty?

    # remove logic
  end

  # return the number of keys stored in the hashmap
  def length
    @buckets.length
  end

  # remove all entries in hashmap
  def clear
    # Need to check to see if this will cause linked list in old buckets to remain in memory
    @buckets = nil
  end

  # return array of all keys in hashmap
  def keys
    # keys logic
  end

  # return array of all values in hashmap
  def values
    # values logic
  end

  # return array containing each key/value pair [[first_key, first_value], [second_key, second_value]...]
  def entries
    # entries logic
  end

  private

  # increase the capacity of the hashmap
  def grow
    # expand capacity
    @capacity *= 2

    # initiate new empty array
    new_buckets_array = Array.new(@capacity)

    # rehash keys and reindex to new capacity

    # final step assign array to instance var
    @buckets = new_buckets_array
  end

  # use hash mod capacity to get index number
  def index_from_hash(hsh)
    hsh % @capacity
  end
end

def new_bucket(hsh, index, key, value)
  @buckets[index] = Bucket.new(hsh)
  @buckets[index].contents.append(key, value)
end
