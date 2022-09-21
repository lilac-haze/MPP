#Играем до трех побед


puts "Welcome to Rock, Paper, Scissors!"


count = 1

user_count = 0

comp_count = 0

until user_count == 3 || comp_count == 3

  comp_guesses = ["rock", "paper", "scissors"]

  puts "Choose Rock/Paper/Scissors:"

  user_guess = gets.chomp.downcase

  comp_guess = comp_guesses.sample

  puts "The computer chose #{comp_guess}."

  if user_guess == comp_guess
    puts "'Dude, it`s a tie:('"
  elsif user_guess == "paper" && comp_guess == "rock"
    puts "Paper stronger than Rock. You win!"
    user_count += 1
  elsif user_guess == "paper" && comp_guess == "scissors"
    puts "Paper loses to Scissors. You lost!"
    comp_count += 1
  elsif user_guess == "scissors" && comp_guess == "rock"
    puts "Scissors loses to Rock. You lost!"
    comp_count += 1
  elsif user_guess == "scissors" && comp_guess == "paper"
    puts "Scissors stronger than Paper. You win!"
    user_count += 1
  elsif user_guess == "rock" && comp_guess == "paper"
    puts "Rock loses to Paper. You lost!"
    comp_count += 1
  elsif user_guess == "rock" && comp_guess == "scissors"
    puts "Rock stronger than Scissors. You win!"
    user_count += 1
  end

  puts "------------"
  puts "User: #{user_count} vs Computer: #{comp_count}"
  puts ""
  if user_count == 3

    puts "Dude, Congrats, you win!"

  elsif comp_count == 3

    puts "'Dude, Computer have beat you!'"

  end

  count += 1


end