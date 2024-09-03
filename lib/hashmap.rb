# frozen_string_literal: true

# lib/hashmap.rb
class Hashmap
  def initialize
    @capacity = 16
    @load_factor = 0.789
    @buckets = []
  end

  # return a numeric hash of `key`
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  # set value to key
  def set(key, value)
    # set logic
  end

  # return value for key
  def get(key)
    raise KeyError if @buckets.empty?

    # get logic
    container = @buckets.each { |bucket| return bucket if bucket.label == hash(key) }
    container.contents.at(container.contents.find(key))
  end

  # boolean if has key in hashmap
  def has?(key)
    false if @buckets.empty?
    hash(key)
    # has? logic
  end

  # remove key from hash and return deleted entry's value
  def remove(key)
    raise KeyError if @buckets.empty?

    # remove logic
    hash(key)
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
end
