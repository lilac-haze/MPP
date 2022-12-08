require 'csv'
require 'io/console'
require 'benchmark'

module Hyper_g

  # Creat a CSV file to save the outputs
  puts("Make sure Results.csv file is not open")
  @csv = CSV.open("Results.csv", "w")

  def Hyper_g.export_to_csv(bins, freqs, method_name)

    @csv << [method_name]
    @csv << bins
    @csv << freqs

  end

  def Hyper_g.get_random_x(min, max)
    # retrns an intger random number in range
    # increase max by 1 in order to be able to have max itself as output
    max = max +1
    return (rand * (max - min) + min).to_i
  end

  def Hyper_g.get_random_y(min, max)
    # retrns an float random number in range
    # increase max by 1 in order to be able to have max itself as output
    return rand * (max - min) + min
  end

  def Hyper_g.factorial(num)
    (1..num).inject(1) { |prod, i| prod * i }
  end

  def Hyper_g.get_combination(num1, num2)
    factorial(num1) / (factorial(num2) * factorial(num1 - num2))
  end

  def Hyper_g.pdf(x, n, nn, m)
    # nn stands for N in pdf formula

    pdf = (get_combination(m, x) * get_combination(nn - m, n - x)).to_f / get_combination(nn, n).to_f
    return pdf

  end

  def Hyper_g.creat_histogram(samples)
    samples = samples.sort
    temp = []
    freqs = []
    bins = []

    for s in samples do
      if temp == [] or temp[0] == s
        # we want to start a new number or we still have same number
        temp.push(s)
      else
        # s is a new number
        freqs.push(temp.length)
        bins.push(temp[0])
        temp = []
        temp.push(s)
      end
    end
    freqs.push(temp.length)
    bins.push(temp[0])
    return bins, freqs
  end

  def Hyper_g.matematics(samples)

    mean = samples.sum(0.0) / samples.size
    sum = samples.sum(0.0) { |element| (element - mean) ** 2 }
    variance = sum / (samples.size - 1)
    standard_deviation = Math.sqrt(variance)
    mean = mean.round(4)
    standard_deviation = standard_deviation.round(4)
    variance = variance.round(4)

    @csv << ["Mean", "Standard_deviation", "Variance"]
    @csv << [mean, standard_deviation, variance]
    @csv << [""]
  end

  ##Main Methods

  def Hyper_g.metropolis_method(n, nn, m, number_of_experiments)

    samples = []

    burn_in = (number_of_experiments * 0.2).to_int
    # We increase number of expriments 20%, because at the end we want to remove 20% of them
    number_of_experiments = (number_of_experiments * 1.2).to_int

    # choose a random number between min and max
    x_max = m
    x_min = 0
    current_x = Hyper_g.get_random_x x_min, x_max
    for i in 1..number_of_experiments do
      samples.push(current_x)
      movement_x = Hyper_g.get_random_x x_min, x_max

      curr_prob = Hyper_g.pdf(current_x, n, nn, m)
      #puts(curr_prob)
      move_prob = Hyper_g.pdf(movement_x, n, nn, m)

      acceptance = [move_prob / curr_prob, 1].min
      if acceptance > rand
        current_x = movement_x
      end
    end
    # burn the initial results since they may not be so accurate
    samples = samples[burn_in..]
    (bins, freqs) = creat_histogram(samples)
    Hyper_g.export_to_csv bins, freqs, "Metropolis Method"
    matematics samples
  end

  def Hyper_g.neyman_method(n, nn, m, number_of_experiments)
    # neyman or accept and reject method
    # maximum of pdf function occurs at mode of pdf which is b here

    mode = (((n + 1) * (m + 1)).to_f / (nn + 2)).floor
    maximum_of_pdf = Hyper_g.pdf(mode, n, nn, m)

    samples = []
    while samples.length < number_of_experiments do
      x = Hyper_g.get_random_x 0, m
      y = Hyper_g.get_random_y 0.0, maximum_of_pdf
      pdf = Hyper_g.pdf(x, n, nn, m)
      if y <= pdf
        samples.push(x)
      end

    end
    (bins, freqs) = creat_histogram(samples)
    export_to_csv bins, freqs, "Neyman Method"
    matematics samples

  end

  def Hyper_g.gibbs_method(n, nn, m, number_of_experiments)

    samples = []
    burn_in = (number_of_experiments * 0.5).to_int
    number_of_experiments = (number_of_experiments * 1.5).to_int

    # choose a random number in range
    x_1 = m
    x_2 = 0
    find_x = Hyper_g.get_random_x x_2, x_1
    for i in 1..number_of_experiments do
      samples.push(find_x)
      new_x = Hyper_g.get_random_x x_2, x_1
      prob_1 = Hyper_g.pdf(find_x, n, nn, m)
      prob_new = Hyper_g.pdf(new_x, n, nn, m)
      changes = prob_new / prob_1
      fit = [changes, 1].min
      if fit > rand
        find_x = new_x
      end
    end

    # burn the initial results since they may not be so accurate
    samples = samples[burn_in..]
    (bins, freqs) = creat_histogram(samples)
    Hyper_g.export_to_csv bins, freqs, "Gibbs Method"
    matematics samples
  end

  select = ""

  while (select != 3)

    puts "What would you like to do?
          1: Info
          2: Calculator
          3: Exit"
    #select = STDIN.getch.to_i
    select = gets.to_i

    if (select == 1)

      puts ("\n----------------------ІНФО----------------------")
      puts "\nЦе програмне забезпечення генерує випадкові величини через Гіпергеометричний розподіл
за допомогою методів Неймана, Метрополіса та Гіббса."
      puts "Щоб розпочати обчислення виберіть другий пункт меню."
      puts "Потім вам запропонують ввести значення N, M та n,"
      puts ("де
N= загальна кількість об'єктів
M= кількість успіхів (примітка: кількість невдач дорівнює N-M)
n= обсяг вибірки")
      puts("M і n повинні бути менше N. Потім потрібно буде ввести кількість експериментів.")
      puts("При закінченні введеня параметрів, будуть розраховані випадкові величини.
Та математичне очікування, дисперсія і середньоквадратичне відхилення для кожного методу.
Всі данні будуть записані в Result.csv.
Додатково буде пораховано час обчислення та автоматично відкриється Output_final.xlsl з гістограмами методів. ")
      puts("\nВиконала: Бузько Ксенія, КС-42\n")
      puts("")
    elsif (select == 2)

      puts("This code samples from Hypergeometric distribution with 3 methods: Metropolis, Neyman and Gibbs. Enter parameters")
      puts("Enter parameters")
      print "N="
      STDOUT.flush
      nn = gets.chomp.to_i
      print "M="
      STDOUT.flush
      m = gets.chomp.to_i
      while m >= nn
        puts("M should be less than N")
        print "M="
        STDOUT.flush
        m = gets.chomp.to_i
      end
      print "n="
      STDOUT.flush
      n = gets.chomp.to_i
      while nn < n
        puts("n should be less than N ")
        print "n="
        STDOUT.flush
        n = gets.chomp.to_i
      end
      print "Number of experiments(Samples)="
      STDOUT.flush
      number_of_expperiments = (gets.chomp).to_i
      time = Benchmark.measure {
        metropolis_method n, nn, m, number_of_expperiments
        neyman_method n, nn, m, number_of_expperiments

        gibbs_method n, nn, m, number_of_expperiments
      }
      # n , nn ,m
      #metropolis_method 100,200,50,2000
      #neyman_method 100,200,50,2000

      puts("Данні результатів збережені в Results.csv")
      puts("Час виконання методів (с):")
      puts time.real

      cmd = "Output_final.xlsx"

      system('start "" ' + cmd)
      break
    elsif (select == 3)
      puts "You have now exited the program"

    end

  end

end