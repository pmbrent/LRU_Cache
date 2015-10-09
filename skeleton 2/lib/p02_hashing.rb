class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash
    self.map.with_index do |el, idx|
      (el * idx).hash
    end.reduce(:+).to_i
  end

end

class String

  def hash
    self.chars.map(&:ord).hash
  end

end

class Hash

  def hash
    self.to_a.flatten.map(&:to_s).sort!.map(&:ord).hash
  end

end
