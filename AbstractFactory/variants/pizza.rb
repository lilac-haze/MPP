require File.expand_path('variants/cafe.rb')

class Pizza < Cafe
  def description
    puts "I am a #{self.class}cafe  with #{@foodname}"
  end
end
