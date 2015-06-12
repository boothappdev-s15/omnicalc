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

    @character_count_without_spaces = @text.length-@text.count(' ')

    @word_count = (@text.split).length

    @occurrences = @text.downcase.scan(@special_word.downcase).length

    #why didn't @text.count(@special_word) work? also tried that divided by @special_word.length
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

    @monthly_payment = ((@apr*@principal)/(1-(1+@apr)**(@years*-1)))/12
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

    @seconds = (@starting-@ending).abs
    @minutes = @seconds/60
    @hours = (@minutes/60).round(2)
    @days = (@hours/24).round(2)
    @weeks = (@days/7).round(2)
    @years = (@weeks.to_f/52).round(2)

    #how to best format numbers, sprintf? but converts to string. possible to display one way andread another?
  end

  #NOTE: worked on desc stats after class 4 due to theme/preferences problem with sublime

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

    if @count.odd?
        @median = @sorted_numbers[ @count/2 ]
    else
        middle_first = @sorted_numbers[ @count/2]
        middle_second = @sorted_numbers [ (@count/2) - 1]
        @median = (middle_first + middle_second)/2
    end

    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

    sq_differences = []

    @numbers.each do |the_number|
        difference = the_number - @mean
        sq_difference = difference**2
        sq_differences.push(sq_difference)
        @variance= sq_differences.sum/@count
    end


    @standard_deviation = @variance**0.5

    leader = nil
    leader_count = 0
    @numbers.each do |the_number|
        occurences = @numbers.count(the_number)
        if occurences > leader_count
            leader = the_number
            leader_count = occurences
        end


    @mode = leader
  end
end
end
