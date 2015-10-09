require_relative 'p02_hashing'
require_relative 'p04_linked_list'

require 'byebug'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    if @count == num_buckets
      resize!
    end

    @store[bucket(key)].insert(key, val)
    @count += 1
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each
    # byebug
    @store.each do |bucket|
      next if bucket.empty?
      bucket.each do |el|
        yield(el.key, el.val)
      end
    end

    @store
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }

    @count = 0
    
    old_store.each do |list|
      next if list.empty?
      list.each do |link|
        set(link.key, link.val)
      end
    end

  nil
  end

  def bucket(key)
    hash = key.hash
    hash % num_buckets
  end
end
