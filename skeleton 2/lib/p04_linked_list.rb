class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prv = nil)
    @key, @val, @next, @prev = key, val, nxt, prv
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail


  def initialize
    @head = Link.new
    @tail = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.head.key
  end

  def last
    self.tail.key
  end

  def empty?
    @head.key.nil? && @head.val.nil? && @head.next.nil?
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end

    nil
  end

  def include?(key)
    self.each { |link| return true if link.key == key }
    false
  end

  def insert(key, val)
    if empty?
      @head = Link.new(key, val)
      @tail = @head
    else
      old_tail = @tail
      @tail = Link.new(key, val)
      old_tail.next = @tail
      @tail.prev = old_tail
    end
  end

  def remove(key)
    if head.key == key
      if head.next
        @head = head.next
      else
        @head = Link.new
      end
    else
      link = head
      until link.next.nil?
        if link.next.key == key
          link.next = link.next.next
          link.next.next.prev = link
          return
        end
      link = link.next
      end
    end
  end

  def each(&proc)
    link = head
    until link.nil?
      proc.call(link)
      link = link.next
    end

    self
  end


  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end
