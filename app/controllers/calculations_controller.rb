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

    @character_count_without_spaces = @text.delete(' ').delete('\n').delete('\r').delete('\t').length

    @word_count = @text.split.length

    @occurrences = @text.scan(@special_word).length
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

  rate = @apr.to_f/12/100
  nper = @years.to_f*12
  pv = @principal.to_f
  c=(pv*rate*(1+rate)**nper)/((1+rate)**nper-1)

    @monthly_payment = c
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
    time = @ending - @starting



    # @seconds = time.to_f % 60
    # mintime = (time - @seconds.to_f)/60
    # @minutes = mintime % 60
    # hourtime = (mintime - @minutes)/60
    # @hours = hourtime % 24
    # daytime = (hourtime - @hours)/24
    # @days = daytime % 7
    # weektime = (daytime - @days)/7
    # @weeks = weektime % 52
    # @years = (weektime - @weeks) / 52

    @seconds = time.to_f
    @minutes = time.to_f/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52
  end

  def descriptive_statistics

    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)
    require 'descriptive_statistics'
    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min
    @median = DescriptiveStatistics.median(@numbers)
    @sum = DescriptiveStatistics.sum(@numbers)

    @mean = DescriptiveStatistics.mean(@numbers)

    @variance = DescriptiveStatistics.variance(@numbers)

    @standard_deviation = DescriptiveStatistics.standard_deviation(@numbers)

    @mode = DescriptiveStatistics.mode(@numbers)

  end
end
