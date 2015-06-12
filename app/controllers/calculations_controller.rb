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

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = (@text.strip.gsub("  "," ").count " ")+1

    @occurrences = @text.downcase.scan(" #{@special_word} ").length

  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    @monthly_payment = ((@apr/1200)*@principal)/(1-(1+@apr/1200)**(-1*@years*12))
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    #    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
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

    @count = (@numbers.to_s.strip.gsub("  "," ").count " ")+1

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median =   if @count.odd? == TRUE
                    @sorted_numbers[(@count/2)]
                else (@sorted_numbers[(@count/2)-1] + @sorted_numbers[(@count/2)]) / 2
                end

    @sum =  @numbers.sum

    @mean = @numbers.sum/@count

    s = []
    n = 0
    while n <= @sorted_numbers.length - 1
        s[n] = (@sorted_numbers[n] - @mean)**2
        n = n+1
    end


    @variance = s.sum/@count

    @standard_deviation = @variance**(0.5)

    @mode = @numbers.uniq.max_by{|i| @numbers.count(i)}
  end
end
