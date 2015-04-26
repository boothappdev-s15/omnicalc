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

    @character_count_without_spaces = @text.length - @text.count(" ")

    @word_count = @text.split.length

    @occurrences = @text.split.count(@special_word)

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

    @monthly_payment =  ((@apr/1200)*@principal) / (1 -(1+(@apr/1200))**(@years*-12))
        # r = @apr/1200
        # numerator = r*@principal
        # denominator = 1 - (1+r)**@years
        # monthly_pmt = numerator / denominator
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

    @seconds = (@ending - @starting)
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/(60*60)
    @days = (@ending - @starting)/(60*60*24)
    @weeks = (@ending - @starting)/(60*60*24*7)
    @months = (@ending -@starting)/(60*60*24*7*(52/12))
    @years = (@ending - @starting)/(60*60*24*7*52)

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

    @median = (@sorted_numbers[((@sorted_numbers.length - 1) / 2)] + @sorted_numbers[((@sorted_numbers.length) / 2)]) / 2.0

    @sum = @numbers.sum

    @mean = @sum/@numbers.length

    sum = 0.0
    @numbers.each do |var|
      sum += ((var - @mean)**2.0)
    end
    @variance = (sum /(@numbers.length))


    @standard_deviation = Math.sqrt(@variance)

    @mode_array = []
      counter = Hash.new(0)
      @numbers.each do |i|
        counter[i] += 1
      end

      counter.each do |k, v|
        if v==counter.values.max
          @mode_array << k
        end
      end


    @mode = @mode_array

  end
end
