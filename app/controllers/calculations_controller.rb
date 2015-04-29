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



    @character_count_without_spaces = @text.length.to_i - @text.count(' ').to_i

        @words = @text.split

    @word_count = @words.length

    @occurrences = @words.count(@special_word)

  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    @apr_percent = @apr / 100

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@apr_percent + @apr_percent/((1 + @apr_percent) ** ((@years * 12) - 1))) * @principal

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


    @time = @ending - @starting

    @years = @time.to_i / 31449600

        @time = @time - @years * 31449600

    @weeks = @time.to_i / 604800

        @time = @time - @weeks * 604800

    @days = @time.to_i / 86400

        @time = @time - @days * 86400

    @hours = @time.to_i / 3600

        @time = @time - @hours * 3600

    @minutes = @time.to_i / 60

        @time = @time - @minutes * 60

    @seconds = @time

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

    if @numbers.count == 0
        return
    end

    @range = @maximum - @minimum

    @median = ( @sorted_numbers[(@numbers.count - 1 ) / 2 ] + @sorted_numbers[@numbers.count / 2] ) / 2

    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

        @diff = 0
        @sqdiff = 0
        @diffs = []
        @diffs_total = 0
        @var_total = 0

        @numbers.each do |number|
            @diff = @mean - number
            @sqdiff = @diff * @diff
            @diffs.push(@sqdiff)
        end

        @diffs.each do |number|
            @diffs_total = @diffs_total + number
            @var_total = @diffs_total / @diffs.length
        end

    @variance = @var_total

    @standard_deviation = Math.sqrt(@var_total)

        @count_mode = []
        @uniq_numbers = @numbers.uniq
        @output = []

        j = 0

        @uniq_numbers.each do |number|
            @count_mode[j] = @numbers.count(number)
            j += 1
        end

        k = 0

        @count_mode.each do |number|
            @output[k] = @uniq_numbers[k] if number == @count_mode.max
            k +=1
        end

        if @count_mode.max == 1
            @mode_calc = "nil"
        else
            @mode_calc = @output.compact.inspect

        end

    @mode = @mode_calc

  end
end
