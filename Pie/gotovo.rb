#initialize pie
class Pie
  attr_reader :area, :izum, :height, :width

  def initialize(pie)
    @pie = pie
    @izum = pie.count('o')

    pie = pie.split("\n")

    @width = pie.first ? pie.first.length : 0
    @height = pie.length

    @area = @width * @height
  end

  # list of possible width
  def possible_widths
    if self.area % self.izum != 0
      return []
    end

    widths = ((self.area / self.izum) / (self.height + 1) + 1..self.width).to_a.select { |i| (self.area / self.izum) % i == 0 }
    widths.reverse

    #widths = ((self.area / self.izum) / (self.height + 1) + 1..self.width).to_a.select{|i| (self.area / self.izum) % i == 0}
    #widths.reverse

    #dims = (1..[Math.sqrt(self.area).floor, self.height].min).each_with_object([]) do |i, a|
    # next if self.area % i > 0
    # j = self.area / i
    # next if j > self.width
    #  a << i
    #  a << j unless i == j
    # end
    # dims.sort!
    #
    #puts widths

  end

  def to_s
    @pie
  end
end

# Slice of the pie
class Slice
  attr_reader :pie, :x, :y, :area, :izum, :width, :height

  def initialize(pie, x, y, width)
    @pie = pie
    @x = nil
    @y = nil
    @area = nil
    @izum = nil
    @width = nil
    @height = nil

    # Check if x or y are outside the bounds of the pie
    if x < 0 || x >= pie.width || y < 0 || y >= pie.height
      return
    end
    @x = x
    @y = y

    # Check If the cake can be split into equal slices
    @area = pie.area % pie.izum == 0 ?
              pie.area / pie.izum : nil
    if @area == nil || width <= 0
      return
    end

    # Check the slice area is rectangular
    @height = @area % width == 0 ? @area / width : nil
    if @height == nil
      return
    end
    @width = width

    # Check if the piece is too wide or too much height
    if x + width > pie.width || y + self.height > pie.height
      return
    end

    @pie = (self.y...(self.y + @height)).to_a.map do |i|
      self.pie.to_s.split("\n")[i][self.x...(self.x + self.width)]
    end.join("\n")
    @izum = @pie.count "o"
  end

  def to_s
    @pie
  end

  # Does this piece contain the proposed point somewhere inside it?
  def contains_point?(x, y)
    return self.x <= x && self.x + self.width > x &&
      self.y <= y && self.y + self.height > y ?
             true : false
  end

  # Check if it consists izum
  def valid?
    @izum != nil
  end
end

# Represents a collection of pieces of cake.
class Slices
  attr_reader :pie, :slices, :length

  def initialize(pie, *slices)
    @pie = pie
    @slices = slices
    @length = slices.length
  end

  # Find coordinates of free dotes. If the slices filled pie fully then its nil
  def free_dotes
    self.pie.height.times do |row|
      self.pie.width.times do |col|
        if self.slices.all? { |p| !p.contains_point?(col, row) }
          return [col, row]
        end
      end
    end
    return nil
  end

  # Checks if last slice is valid
  def valid?()
    return self.slices.last.valid?
  end

  # Checks if any of the pieces obviously overlap with one another
  def overlap?()
    self.slices.any? do |dot|
      self.slices.any? do |d|
        d != dot && (
          d.contains_point?(dot.x, dot.y) ||
            d.contains_point?(dot.x + dot.width - 1, dot.y) ||
            d.contains_point?(dot.x, dot.y + dot.height - 1) ||
            d.contains_point?(dot.x + dot.width - 1, dot.y + dot.height - 1))
      end
    end
  end

  # Checks if slices consist only one izum
  def only_one_izum?()
    self.slices.all? do |d|
      d.izum == 1
    end
  end

  # Returns a new list of slices
  def next_slices()
    if self.slices.empty?
      return self
    end
    earlier = self.slices.first(self.length - 1)
    forget = self.slices.last
    widths = self.pie.possible_widths()
    i = widths.find_index(forget.width)
    if i + 1 == widths.length
      return Slices.new(self.pie, *earlier).next_slices()
    end
    np = Slice.new(self.pie, forget.x, forget.y, widths[i + 1])
    na = [*earlier, np]
    return Slices.new(self.pie, *na)
  end

  # Returns a new slices list where a new piece of maximum possible length is added to the
  # collection at the next possible free point
  def new_slices()
    if self.free_dotes.nil?
      return self
    end
    x, y = self.free_dotes
    np = Slice.new(self.pie, x, y, self.pie.possible_widths.first)
    na = [*self.slices, np]
    return Slices.new(self.pie, *na)
  end
end


#check if everything valid, all slices consist only one izum, if it overlap, check slice by slice
def cut pie

  pie = Pie.new(pie)
  sl = Slice.new(pie, 0, 0, pie.possible_widths.first)
  done = Slices.new(pie, sl)

  while done.length > 0 && done.length <= pie.izum
    if done.length == pie.izum
      if done.valid? && done.only_one_izum? && !done.overlap? && done.free_dotes.nil?
        return done.slices.map { |p| p.to_s }
      else
        done = done.next_slices
        next
      end
    else
      if done.valid? && done.only_one_izum? && !done.overlap?
        done = done.new_slices
        next
      else
        done = done.next_slices
        next
      end
    end
  end
  return []
end

pie = "
.o.o....
........
....o...
........
.....o..
........
".strip

res = cut(pie)
res = res.join(", \n\n")

puts res

