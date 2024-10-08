# frozen_string_literal: true

require_relative 'bucket'
require_relative 'hasher'

# lib/hashmap.rb
class Hashmap
  attr_reader :buckets, :capacity, :load_factor

  def initialize
    @capacity = 16
    @load_factor = 0.789
    @buckets = Array.new(@capacity)
    @hasher = Hasher.new
  end

  # set value to key
  def set(key, value)
    grow if length > @capacity * @load_factor
    hsh = @hasher.make_hash(key)
    index = index_from_hash(hsh)

    @buckets[index].nil? ? new_bucket(hsh, index, key, value) : @buckets[index].contents.append(key, value)
  end

  # boolean if has key in hashmap
  def has?(key)
    return false if @buckets.empty?

    @hasher.make_hash(key)
    @buckets.each do |bucket|
      next if bucket.nil?
      return true if bucket.contents.include_key?(key)
    end
    false
  end

  # return the number of keys stored in the hashmap
  def length
    len = 0
    @buckets.each do |bucket|
      next if bucket.nil?

      len += bucket.contents.length
    end
    len
  end

  # return value for key
  def get(key)
    raise KeyError if @buckets.empty?
    return nil unless has?(key)

    index = index_from_hash(@hasher.make_hash(key))
    position = @buckets[index].contents.find_key(key)
    @buckets[index].contents.at(position).value
  end

  # remove key from hash and return deleted entry's value
  def remove(key)
    raise KeyError if @buckets.empty?

    index = index_from_hash(@hasher.make_hash(key))
    position = @buckets[index].contents.find_key(key)
    @buckets[index].contents.remove_at(position)
  end

  # return array of all keys in hashmap
  def keys
    raise KeyError if @buckets.empty?

    output = []
    # need to figure out this logic
    @buckets.each do |bucket|
      next if bucket.nil?

      output.concat(bucket.keys)
    end
    output
  end

  # return array of all values in hashmap
  def values
    raise KeyError if @buckets.empty?

    output = []
    @buckets.each do |bucket|
      next if bucket.nil?

      output.concat(bucket.values)
    end
    output
  end

  # return array containing each key/value pair [[first_key, first_value], [second_key, second_value]...]
  def entries
    raise KeyError if @buckets.empty?

    output = []
    @buckets.each do |bucket|
      next if bucket.nil?

      output.concat(bucket.keys_and_values)
    end
    output
  end

  # remove all entries in hashmap
  def clear
    @buckets.each do |bucket|
      next if bucket.nil?

      # We're just dumping values, no need to save them
      bucket.keys.each do |_key|
        next if bucket.nil?

        _ = bucket.contents.pop
      end
    end
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  private

  # increase the capacity of the hashmap
  def grow
    # expand capacity
    @capacity *= 2

    old_buckets = @buckets
    @buckets = Array.new(@capacity)

    # rehash keys and reindex to new capacity
    old_buckets.each do |entry|
      next if entry.nil?

      entry.keys_and_values.each do |pair|
        set(*pair)
      end
    end
  end

  # use hash mod capacity to get index number
  def index_from_hash(hsh)
    hsh % @capacity
  end

  def new_bucket(hsh, index, key, value)
    @buckets[index] = Bucket.new(hsh)
    @buckets[index].contents.append(key, value)
  end
end
