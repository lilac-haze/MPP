def alphabet_position(text)

  puts "Your string: #{text}"
  answ = ""
  text = text.downcase
  chars = text.split('')

  for char in chars do
    count = 0
    for letter in 'a'..'z'
      count += 1
      if letter == char
        answ += "#{count} "
      end
    end
  end

  # answ.delete_suffix(' ') #delete probel
  puts "Alphabet Position:"
  puts answ

end

alphabet_position("The sunset sets at twelve o' clock.")