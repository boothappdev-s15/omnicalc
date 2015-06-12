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

    @character_count_without_spaces = @text.gsub(' ', '').length

    @word_count = @text.split.size

    @occurrences = @text.scan(@special_word).size
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    if @apr > 1
        @rate = @apr / 100
    end

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    
    # formula is from http://www.1728.org/loanform.htm
    rate = @apr/12
    months = 12 * @years

    @monthly_payment = @principal * (rate + (rate/(((1+rate)**months)-1 )))
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
    temp_time = @ending - @starting
    @seconds = temp_time/1.seconds
    @minutes = temp_time/1.minutes
    @hours = temp_time/1.hours
    @days = temp_time/1.days 
    @weeks = temp_time/1.weeks
    @years = temp_time/1.years
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = @numbers[@count/2]

    @sum = @numbers.sum

    @mean = @sum/@count

    var_sum = 0
    @numbers.each{|a| var_sum+=((a-@mean)**2)}
    @variance = var_sum/(@numbers.length-1)

    @standard_deviation = Math.sqrt(@variance)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    
    @mode = @numbers.max_by { |v| freq[v] }
  end
end
