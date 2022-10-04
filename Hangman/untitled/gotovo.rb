class Hangman
  attr_accessor :word_state, :guess, :comp, :player, :word, :guessed_letters, :chelovechek

  def initialize
    @guess = nil
    @guessed_letters = []
    # @chelovechek = []

    #@chelovechek = File.foreach("hangman_drawings.txt").map { |line| line[0, line.index(',')] }
    #  @chelovechek = File.readlines('hangman_drawings.txt').map { |line| line.split(',') }.map(&:first)
    IO.readlines("hangman_drawings.txt", '').each do |line|
      @chelovechek = line.split(",").collect(&:strip)

    end

    @comp = ComputerPlayer.new #hangman
    @player = Player.new

    start_game(comp, player)
  end

  def start_game(comp, player)
    self.word = comp.choose_word
    update_word_state_initial(word.length)
    play_game(comp, player)

  end

  def play_game(comp, player)
    num_guesses = 0
    turns_left = 7
    count = 0

    puts "Welcome to the Hangman game!"
    puts "Try to guess this word:\n"

    while num_guesses < 7
      puts "#{self.word_state}"
      puts "Guessed: #{@guessed_letters}" unless @guessed_letters.empty?
      puts "Lives: #{turns_left}"
      self.guess = player.make_guess
      @guessed_letters << self.guess
      evaluation = comp.evaluate_guess(self.guess, self.word)

      if evaluation == "no"
        puts "You missed"
        num_guesses += 1
        turns_left -= 1
        if count == 0
          puts "Your hangtree is ready for u!"
          puts @chelovechek[count]
          count += 1
          puts "\n\n"
        elsif count == 6
          puts "You died, loser!"
          puts @chelovechek[count]
          count += 1
          puts "\n\n"
        else
          puts "You are closer to death!"
          puts @chelovechek[count]
          count += 1
          puts "\n\n"
        end

      elsif evaluation == "yes"
        puts "Dude you are slay! Congrats!"
        break
      else
        update_word_state_with_indices(self.guess, evaluation)
        unless self.word_state.split(//).include?("*")
          puts "Dude you are slay! Congrats!"
          break
        end
      end

    end
  end

  
  def update_word_state_initial(length)
    self.word_state = "*" * length
  end

  
  def update_word_state_with_indices(guess, indices)
    indices.each do |i|
      self.word_state[i] = guess
    end
  end

end

class Player
  attr_accessor :word

 
  def make_guess
    print "Enter a letter or word to guess: "
    gets.chomp
  end

end

class ComputerPlayer
  LETTERS = ("a".."z").to_a.map { |x| x.to_sym }

  attr_accessor :word, :dictionary, :letters_guessed

  
  def initialize
    @dictionary = File.readlines("hangman_words.txt").map { |word| word.strip }
    @dictionary.map! { |word| word.gsub(/[^a-z]/, "") }

    @letters_guessed = []
  end

  def choose_word
    self.dictionary.sample
  end

  
  def update_dictionary_initial(length)
    self.dictionary = self.dictionary.select do |word|
      word.length == length
    end
  end

  def update_dictionary_with_word_state(word_state)
    self.dictionary = self.dictionary.select do |word|
      word_match = true
      (0..word.length).each do |index|
        word_match = false if word[index] != word_state[index] && word_state[index] != "*"
      end
      word_match
    end
  end

  def update_dictionary_remove_letter(letter)
    self.dictionary = self.dictionary.select do |word|
      !word.split(//).include?(letter)
    end
  end

  def evaluate_guess(guess, word)
    if guess.length > 1
      return "yes" if guess == word
      return "no" if guess != word
    end

    letters = word.split(//)
    letter_locations = []
    letters.each_with_index do |letter, index|
      if letter == guess
        letter_locations << index
      end
    end
    if letter_locations.length == 0
      return "no"
    else
      return letter_locations
    end
  end


  def winning_guess?(guess, word)

    return false if guess.nil?

    if guess == word
      return true
    else
      return false
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Hangman.new
end
