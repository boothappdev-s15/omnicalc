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

    @character_count_without_spaces = (@text.length - @text.scan(/\s+/).count)


    @word_count = @text.split.length

    @occurrences = (@text.split.length - @special_word.split.length)

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

    # Principal + (Principal*apr) = Amount due left (amount_due)
    # Next year: amount_due + (amount_due*apr) = amount_due (repeat until years = 0)
    # We want to find out how much to pay so it's the total of the last year's amount left/12

    rate = (@apr/100) / (@years*12)
    number_of_years = @years*12

    @monthly_payment = (rate*@principal)/(1-(1+rate)**(-(number_of_years)))
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
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/3600
    @days = (@ending - @starting)/86400
    @weeks = (@ending - @starting)/604800
    @years = (@ending - @starting)/31449600
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

    @range = @numbers.max - @numbers.min

    sorted = @numbers.sort
    length = sorted.length

    @median = (sorted[(length - 1) / 2] + sorted[length / 2]) / 2.0

    running_total = 0
        @numbers.each do |number|
            running_total = running_total + number
        end
    @sum = running_total


    running_total = 0
    @numbers.each do |number|
      running_total = running_total + number
    end
    mean = running_total/@numbers.length
    @mean = mean

    running_total = 0
    @numbers.each do |number|
      running_total = running_total + number
    end
    mean = running_total/@numbers.length
    diff = []
    @numbers.each do |x|
      diff.push (x - mean)**2
      end
    total = 0
    diff.each do |y|
      total = total + y
    end
    var = total/diff.length
    @variance = var

       running_total = 0
    @numbers.each do |number|
      running_total = running_total + number
    end
    mean = running_total/@numbers.length
    diff = []
    @numbers.each do |x|
      diff.push (x - mean)**2
      end
    total = 0
    diff.each do |y|
      total = total + y
    end
    var = total/diff.length
    stdv = Math.sqrt(var)
    @standard_deviation = stdv

    most_frequent_item = @numbers.uniq.max_by{ |i| @numbers.count(i)}
    @mode = most_frequent_item
  end
end
