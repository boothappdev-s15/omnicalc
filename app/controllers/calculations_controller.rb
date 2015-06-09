class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_length=@text.length

    @character_count_with_spaces = text_length

    text_length_nospace= text_length - @text.count(" ")

    @character_count_without_spaces = text_length_nospace

    word_count=@text.scan(/\w+/).size

    @word_count = word_count

    occurrences = @text.count(@special_word)

    @occurrences = occurrences
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

    effective_interest=@apr/12
    payment_periods=@years*12
    denominator = 1-((1+effective_interest)**payment_periods)
    den_num = effective_interest/denominator

    @monthly_payment =  (effective_interest + den_num) * @principal
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

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365
end

    def median(array)
      sorted = array.sort
      len = sorted.length
      return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
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

    @median = median(@numbers)

    @sum = @numbers.inject(:+)

    @mean = @sum/@count

    @variance= 0
    variance = @numbers
    variance.each do |the_number|
        var2 =(the_number - @mean)**2
        @variance = @variance+(var2/@count)
    end

    @standard_deviation = @variance**0.5

    @mode = 0
    count_hash ={}
    mode = @numbers
    mode.each do |the_number|
        if count_hash.has_key? the_number
            count_hash[the_number] = count_hash[the_number] +1
            else
                count_hash[the_number] = 1
        end
    end

    @mode = 0
    @mode_max = 0
    count_hash.each do |key,value|
        if value > @mode_max
            @mode= key
            @mode_max = value
            else
        end

    @mode = @mode
    end
end
end

