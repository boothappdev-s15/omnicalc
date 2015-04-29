
class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text].chomp
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split.count

    special_word_clean = @special_word.downcase.to_s
    special_word_count = @text.downcase.scan(special_word_clean).count
    @occurrences = special_word_count
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

    apr_decimal = @apr/100/12
    months = @years*-12
    num = apr_decimal*@principal
    den = 1-((1+apr_decimal)**months)

    @monthly_payment = num/den

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

    seconds = (@ending.to_f-@starting.to_f)

    minutes = (@ending.to_f-@starting.to_f)/(60)

    hours = (@ending.to_f-@starting.to_f)/(60*60)

    days = (@ending.to_f-@starting.to_f)/(60*60*24)

    weeks = (@ending.to_f-@starting.to_f)/(60*60*24)/7

    months = (@ending.to_f-@starting.to_f)/(60*60*24)/30

    years = (@ending.to_f-@starting.to_f)/(60*60*24)/365

    @seconds = seconds
    @minutes = minutes
    @hours = hours
    @days = days
    @weeks = weeks
    @months = months
    @years = years
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

    range = @numbers.max-@numbers.min
    @range = range

    # def median(@numbers)
      sorted = @numbers.sort
      len = sorted.length
      median = (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    # end

    @median = median

    @sum = @numbers.sum

    mean = @numbers.sum/@numbers.count
    @mean = mean

    new_numbers = []
    @numbers.each do |the_number|
    new_numbers.push ((the_number - @mean)**2)
    end

    @variance = new_numbers.sum/new_numbers.count

    @standard_deviation = Math.sqrt(@variance)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = @numbers.max_by { |v| freq[v] }

  end
end
