class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - (@text.count " ")

    @word_count = @text.tr('/\\-', ' ').split(' ').count

    matched_words = @text.tr('/\\-', ' ').split(' ').find_all {|word| word.downcase.scan(/[a-zA-Z]/).join == @special_word.downcase}
    @occurrences = matched_words.count
    end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    @monthly_payment = (@principal*(@apr/100/12)*((1+(@apr/100/12))**(@years*12)))/(((1+(@apr/100/12))**(@years*12))-1)

  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365.25

  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    if @count%2 == 0
        @median = (@sorted_numbers[(@count/2)-1]+@sorted_numbers[(@count/2)])/2
    else
        @median = @sorted_numbers[((@count+1)/2)-1]
    end

    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      return running_total
    end

    @sum = sum(@numbers)

    def mean(list_of_numbers)
        lengh_of_numbers = list_of_numbers.count
        return sum(list_of_numbers)/lengh_of_numbers
    end

     @mean = mean(@numbers)

    def variance(list_of_numbers)
      lengh_of_numbers = list_of_numbers.count
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + ((number-mean(list_of_numbers))**2)
      end
      return running_total/lengh_of_numbers
    end

    @variance = variance(@numbers)

    @standard_deviation = @variance**0.5

    def mode(list_of_numbers)
        count_frequency = list_of_numbers.inject(Hash.new(0)) {|x, y| x[y] = list_of_numbers.count(y); x}
        return count_frequency.key(count_frequency.values.max)
    end

    @mode = mode(@numbers)

  end
end
