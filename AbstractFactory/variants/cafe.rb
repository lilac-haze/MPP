class Cafe
  attr_accessor :foodname
  def initialize(foodname)
    @foodname = foodname
  end
end

class Cafes
  def initialize(number_of_meals, type_of_meal)
    foodname = nil
    cafes = nil

    if type_of_meal == :pizza
      foodname = 'Mazarella'
      cafes = PizzaFactory.new
    elsif type_of_meal== :sushi
      foodname = 'Dragon roll'
      cafes = SushiFactory.new
    elsif type_of_meal== :ramen
      foodname = 'Miso soup'
      cafes = RamenFactory.new
    end

    @cafe = []
    number_of_meals.times do |i|
      @cafe << cafes.create("#{foodname} #{i + 1}")
    end
  end

  def output
    @cafe.each {|c| c.description}
  end
end
