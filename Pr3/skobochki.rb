def func(s)
  if s.empty?
    puts "true"
  end
  stack = []
  s.each_char do |c|
    case c
    when '(', '{', '['
      stack.push(c)
    when ')'
      if stack.pop() != '('
        puts "false"
        abort
      end
    when '}'
      if stack.pop() != '{'
        puts "false"
        abort
      end
    when ']'
      if stack.pop() != '['
        puts "false"
        abort
      end
    end
  end
  if stack.empty?
    puts "true"
  end
end

s = gets.chomp
return func(s)

