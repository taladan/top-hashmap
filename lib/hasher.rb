# frozen_string_literal: true

class Hasher
  def initialize
    @foo = nil
  end

  def make_hash(key)
    key = key.to_s
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end
end
