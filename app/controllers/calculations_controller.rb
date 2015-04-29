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

    @character_count_without_spaces = @text.length - @text.count(“ “)

    @word_count = @text.split(“ “).count

    @occurrences = @text.downcase.split(“ “).count(@special_word.downcase)
    #@text.scan(@special_word).count
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


    r = (@apr / 12) / 100

    growth_rate = 1 + r

    n = @years * 12

    numerator = @principal * r * (growth_rate ** n)

    denominator = (growth_rate ** n) - 1

    @monthly_payment = numerator / denominator
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
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365.25
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

    if @sorted_numbers.length.odd?
        @median = @sorted_numbers[(@sorted_numbers.length - 1) / 2]
    else
        first_middle_index = @sorted_numbers.length/2 - 1
        second_middle_index = @sorted_numbers.length / 2
        first_middle_value = @sorted_numbers[first_middle_index]
        second_middle_value = @sorted_numbers[second_middle_index]
        @median = (first_middle_value + second_middle_value) / 2
    end

    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

    @variance = "Replace this string with your answer."

    # numerator = sum(x - mean)^2
    # denominator = (n - 1)

    variance_array = []
    @numbers.each do |num|
        difference = num - @mean
        difference_squared = difference ** 2
        variance_array.push(difference_squared)
    end

    numerator = variance_array.sum
    denominator = @numbers.length

    @variance = numerator / denominator

    @standard_deviation = @variance**(0.5)

    frequency_by_number = {}
    @numbers.each do |num|
        frequency_by_number[num] = @numbers.count(num)
    end
    frequencies = frequency_by_number.values
    max = frequencies.max
    modes = []
    frequency_by_number.each do |num, frequency|
        if frequency == max
            modes.push(num)
        end
    end
    # if modes.count > 1
    #     @mode = modes
    # else
    #     @mode = modes.first
    # end

    @mode = modes.first

end
end
