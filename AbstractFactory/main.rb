require File.expand_path('factories/factories.rb')
require File.expand_path('variants/cafe.rb')
require File.expand_path('variants/pizza.rb')
require File.expand_path('variants/ramen.rb')
require File.expand_path('variants/sushi.rb')


cafe_factory = Cafes.new(1, :pizza)
cafe_factory.output
cafe_factory = Cafes.new(1, :sushi)
cafe_factory.output
cafe_factory = Cafes.new(1, :ramen)
cafe_factory.output
