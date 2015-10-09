require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@store[key])
      return @map[key]
    else
      eject! if @max == count
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    value = @prc.call(key)
    @store.insert(key, value)
    @map.set(key, @store.tail)
    value
  end

  def update_link!(link)
    return if @tail == link

    if link == @store.head
      @store.remove(link)
      return
    end

    a = link.next
    b = link.prev
    a.prev = b
    b.next = a

    link.prev = @store.tail
    @store.tail.next = link
  end

  def eject!
    @map.delete(@store.head.key)
    @store.remove(@store.head)
  end
end
