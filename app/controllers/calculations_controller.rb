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

    @character_count_without_spaces = (@text.length)-(@text.count(" "))

    @word_count = @text.split(" ").count

    @all_words = @text.split(" ")

    @matched_words = []

    @all_words.each do |word|
        if word.downcase == @special_word.downcase
            @matched_words.push(word)
        end
    end

    @occurrences = @matched_words.count

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

    @r = ((@apr/100) / 12)

    @payments = (12 * @years)
    @expo = ((1 + @r)**@payments)
    @denominator = (@expo - 1)
    @numerator = (@principal * (@expo * @r))
    @monthly_payment = (@numerator / @denominator) #"Replace this string with your answer."
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

    @range_calc = []

    @numbers.each do |range|
        if range == @numbers.min
        elsif range == @numbers.max
            @range_calc.push(range)
        end
    end

    @range = @range_calc

    median_sorted = @numbers.sort
    list = sorted.length
        if list %2 != 0
        @median = sorted[list/2]
        else
        @median = (sorted[list/2]+sorted[(list/2)-1])/2.0
        end

    @median = @median

    running_total = 0
    @numbers.each do |number|
        running_total = running_total + number
        end

    @sum = running_total

    @mean = @sum / @count

    running_total2 = 0
    @numbers.each do |number|
        running_total2 = running_total2 + ((number - @mean)**2)
    end

    @variance = running_total2 / @count

    @standard_deviation = Math.sqrt(@variance)

    @mode = @numbers.uniq.max_by{ |i| @numbers.count( i ) }

    # @mode = count = Hash.new(0)

    #    @numbers.each {|word| count[word] += 1}
    #    count.sort_by { |k,v| v }.last
    #    end
end
