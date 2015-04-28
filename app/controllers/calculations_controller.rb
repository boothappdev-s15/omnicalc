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
    @years = @days / 365
end

  #def find_median(array)
    #length = array.count
    #if length.even?
        # take middle two numbers and divide by two
        # [1, 2, 10, 25, 26, 30]
        #upper = (6 / 2) # 3
        #lower = (6 / 2) - 1 # 2
        #upper_val = array[upper]
        #lower_val = array[lower]
        #(upper_val + lower_val) / 2
    #else
        # 5 / 2 + 1 then round up
        # find middle number in array
    #end
  #end

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


    @median = "Replace this string with your answer."
    #array = [1, 2, 3, 5, 10]
    #array_2 = [1, 3, 9, 15, 16, 25]
    #median_2 = find_median(array_2)
    #median_1 = find_median(array)
    if @sorted_numbers.length.odd?
        @median = @sorted_numbers[(@sorted_numbers.length - 1) / 2]
    else @sorted_numbers.length.even?
        @median = (@sorted_numbers[@sorted_numbers.length / 2] + @sorted_numbers[sorted_numbers.length/2 - 1].to_f
    end

    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

    @variance = "Replace this string with your answer."

    variance_array = []
    var = @numbers
    var.each do |squared_mean|
        variance_array.push((squared_mean-@mean)**2)
        sum_varriance = varriance_array.sum
        @variance = sum_variance/@count
    end

    @standard_deviation = @varriance**(0.5)

    @mode = "Replace this string with your answer."
    # I do not know how to get the correct key/value pair
end
end
