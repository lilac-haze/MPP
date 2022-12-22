

module AbstractFactory
  def create(foodname)
    raise NotImplementedError, "You should implement this method"
  end
end

class PizzaFactory
  include AbstractFactory
  def create(foodname)
    Pizza.new foodname
  end
end

class SushiFactory
  include AbstractFactory
  def create(foodname)
    Sushi.new foodname
  end
end

class RamenFactory
  include AbstractFactory
  def create(foodname)
    Ramen.new foodname
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

