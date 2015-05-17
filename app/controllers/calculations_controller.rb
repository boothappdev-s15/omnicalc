class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    spaces=@text.count " "

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length-spaces

    @word_count = spaces+1



    text_words = @text.downcase.scan(/\w+/)  #get an array of lower case words
    search_word=@special_word.downcase
    text_count = 0

    text_words.each do |word|
        text_count += (word == search_word) ? 1 : 0
    end
    @occurrences = text_count


    #(firm.inflection_point ? 1 : 0)

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

    payment = (@apr/1200 * @principal) / ( 1 - ((1 + @apr/1200)**(-@years*12)))
    @monthly_payment = payment
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

    #starting_seconds = @starting.year*31536000 + @starting.yday*86400 + @starting.hour*3600 + @starting.min*60 + @starting.sec
    #ending_seconds = @ending.year*31536000 + @ending.yday*86400 + @ending.hour*3600 + @ending.min*60 + @ending.sec
    result_seconds = @ending - @starting

    @seconds = result_seconds
    @minutes = result_seconds / 60
    @hours = result_seconds / 60 / 60
    @days = result_seconds / 60 / 60 / 24
    @weeks = result_seconds / 60 / 60 / 24 / 7
    @years = result_seconds / 60 / 60 / 24 / 365.25
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


    numbers_length=@numbers.count

    if numbers_length%2 != 1
        @median = (@numbers.sort[numbers_length/2-1] + @numbers.sort[numbers_length/2])/2
    else
        @median = @numbers.sort[numbers_length/2]
    end


    @sum = @numbers.inject(:+)

    @mean = @numbers.inject(:+) / @numbers.count


    mean_of_list = @numbers.inject(:+) / @numbers.count
    variance_sum_of_list=0
    @numbers.each{|a| variance_sum_of_list+=((a-mean_of_list)**2)}
    variance_of_list = variance_sum_of_list/(@numbers.length)
    @variance = variance_of_list

    @standard_deviation = Math.sqrt(variance_of_list)


    def mode(mode)
      mode_return = mode.inject({}) { |k, v| k[v] = mode.count(v); k }
      mode_return.select { |k,v| v == mode_return.values.max }.keys
    end
    @mode = mode(@numbers)

  end
end
