# Check is it integer
def valid_input_operator?(num)
  !/^[1-4]$/.match(num).nil?
end

# Check the num in menu
def valid_input_int?(num)
  !/^\d+$/.match(num).nil?
end


def menu
  puts "Choose between operations: add(+), subtract(-), multiply(*), or divide(/)?"
  puts "   1) Add\n   2) Subtract\n   3) Multiply\n   4) Divide"
  op = gets.chomp
  while !valid_input_operator?(op)
    puts "Try again! Choose between 1 to 4"
    puts "\t   1) Add\n 2) Subtract\n 3) Multiply\n 4) Divide"
    op = gets.chomp
  end
  op.to_i
end

# Step 2: Compute
def compute
  puts "Calculator"
  puts "What's the first number?"
  num = gets.chomp
  while !valid_input_int?(num)
    puts"Try again! Write an integer"
    num = gets.chomp
  end
  num.to_i

  puts "What's the second number?"
  num1 = gets.chomp
  while !valid_input_int?(num)
    puts"Try again! Write an integer"
    num1 = gets.chomp
  end
  num1.to_i
  op = menu
  if op == 1
    puts "The answer is #{num + num1}."
  elsif op == 2
    puts "The answer is #{num - num1}."
  elsif op == 3
    puts "The answer is #{num * num1}."
  elsif op == 4
    if num1 == 0
      raise ArgumentError.new("Can't divide numbers by zero")
      #puts "Can't divide numbers by zero"
    else
      puts "The answer is #{num.to_f / num1.to_f}."
    end
  end
end

compute


