class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.head.key
  end

  def last
    last = nil
    self.each do |link|
      last = link if link.next.nil?
    end

    last
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
    else
      last.next = Link.new(key, val)
    end
  end

  def remove(key)
    if head.key == key
      @head = head.next
    else
      link = head
      until link.next.nil?
        if link.next.key == key
          link.next = link.next.next
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
