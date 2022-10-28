def main(story)
  aray1 = story.downcase
  aray = aray1.gsub(/[^ \'\w\s]|\p{Punct}{2,}/, "").split

  map = {}

  aray.delete("'")

  aray.each do |word|
    if map.has_key?(word.downcase)
      map[word] = map[word] + 1
    else
      map[word] = 1
    end
  end


  map = Hash[map.sort_by { |k, v| v }.reverse]

  arr = map.keys

  result = arr.take(3)

  puts result

end

main("In a village of La Mancha, the name of which I have no desire to call to
mind, there lived not long since one of those gentlemen that keep a lance
in the lance-rack, an old buckler, a lean hack, and a greyhound for
coursing. An olla of rather more beef than mutton, a salad on most
nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra
on Sundays, made away with three-quarters of his income.")