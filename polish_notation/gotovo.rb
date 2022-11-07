# returns true if the input is an operator and false otherwise
def operator?(str)
  return !str.match?(/[[:digit:]]/)
  #str == '+' or str == '-' or str == '*' or str == '/' or str == '%' or str == '^' or str == '(' or str == 'cos'
end

# returns true if the input is an operand and false otherwise
def operand?(str)
  !operator?(str) && str != ')'
end

# returns true if the input is a left parenthesis and false otherwise
def leftParen?(str)
  str.eql? '('
end

# returns true if the input is a right parenthesis and false otherwise
def rightParen?(str)
  str.eql? ')'
end

# returns the stack precedence of the input operator
def stackPrecedence(operator)
  if operator == '+' or operator == '-'
    return 1
  elsif operator == '*' or operator == '/' or operator == '%'
    return 2
  elsif operator == '^'
    return 3
  elsif operator == "cos" or operator == "sin" or operator == "tan" or operator == "cot"
    return 4
  else
    return 0
  end
end

def triginometric?(str)
  return str == "c" || str == "o" || str == "s" || str == "i" || str == "n" || str == "t" || str == "a"
  #return str == "s" or str == "i" or str == "n" or str == "c" or str == "o" or str == "t" or str == "a"
end

# converts the infix expression string to prefix expression and returns it
def infixToPrefix(str)

  Array stack = Array.new
  Array output = Array.new
  prefixStr = Array.new
  needToMerge = false
  triginometric = ""

  for i in str.split(//).reject { |x| x == " " }
    case
    when leftParen?(i)
      stack << triginometric + " " if !triginometric.empty?
      stack << i

      triginometric = ""
      needToMerge = false
    when rightParen?(i)
      while stack.length != 0 && !leftParen?(stack.last) do
        el1 = output.pop
        el2 = output.pop
        el = stack.pop

        output.push(el + el2 + el1)
      end
      stack.pop
      needToMerge = false

    when !operator?(i)
      output << output.pop.strip + i + " " if needToMerge

      output << i + " " if !needToMerge

      needToMerge = true
    else

      if triginometric?(i)
        triginometric << i
        next
      end

      while stack.length != 0 && stackPrecedence(i.to_s) <= stackPrecedence(stack.last&.strip) do
        el1 = output.pop
        el2 = output.pop
        el = stack.pop

        output.push(el + el2 + el1)
      end

      stack.push(i + " ")
      needToMerge = false
    end
  end

  while stack.length != 0 do

    el1 = output.pop
    el2 = output.pop
    el = stack.pop

    tmp = ""
    tmp << el if !el.nil?
    tmp << el2 if !el2.nil?
    tmp << el1 if !el1.nil?
    output.push(tmp)
  end

  return output.last
end

# evaluate the equation string and returns the result
def evaluateEquation(exprStr)
  Array stack = Array.new
  splitStr = Array.new
  splitStr = exprStr.split().reverse
  count = 0;
  str = splitStr[count]
  while (str = splitStr[count]) != nil do
    #if str == "cos" || str == "sin" || str == "tan" || str == "cot"
    #stack.push(str)
    if operand?(str)
      stack.push(str)
    elsif str == "cos" || str == "sin" || str == "tan" || str == "cot"
      x = stack.pop()
      y = 0
      result = applyOperator(x, y, str)
      stack.push(result)
    else
      y = stack.pop()
      x = stack.pop()

      #elsif operator?(str)
      #y = stack.pop()

      #x = stack.pop()
      result = applyOperator(x, y, str)
      stack.push(result)
    end
    count += 1
  end
  stack.pop()
end

# applies the operators to num1 and num2 and returns the result
def applyOperator(num1, num2, opr)
  if (opr == '+')
    num1.to_i + num2.to_i
  elsif (opr == '-')
    num1.to_i - num2.to_i
  elsif (opr == '*')
    num1.to_i * num2.to_i
  elsif (opr == '/')
    num1.to_i / num2.to_i
  elsif (opr == '%')
    num1.to_i % num2.to_i
  elsif (opr == '^')
    num1.to_i ** num2.to_i
  elsif (opr == 'cos')
    Math.cos(num1)
  elsif (opr == 'sin')
    Math.sin(num1)
  elsif (opr == 'tan')
    Math.tan(num1)
  elsif (opr == 'cot')
    1 / Math.tan(num1)
  end
end

result = infixToPrefix("cos(10+1)")
res1 = evaluateEquation(result)
puts result
puts res1