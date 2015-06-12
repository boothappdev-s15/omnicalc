class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    @character_count_with_spaces = @text.length

    words = @text.split

    @character_count_without_spaces = words.join.length

    @word_count = words.length

    # Does this next line simply create a new hash?  What does the number 0 do?
    counts = Hash.new(0)

    # I don't understand what this next line of code is doing.
    # It goes into the words array, then for each element in the array it adds one to the 
    # counts hash with that word as the key?  When was the hash key created?
    words.each { |name| counts[name] += 1 }

    @occurrences = counts["#{@special_word}"]
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # converts apr into decimal
    apr_d = @apr / 100

    @monthly_payment = @principal * ( apr_d / ( 1 - ( 1 + apr_d ) ** - @years ) )
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = @count % 2 == 1 ? @sorted_numbers[@count/2] : (@sorted_numbers[@count/2 - 1] + @sorted_numbers[@count/2]).to_f / 2
    # Is the previous expression the same as writing
    # if @count % 2 == 1
    #   sorted[len/2]
    # else
    #   (sorted[len/2 - 1] + sorted[len/2]).to_f / 2
    # end

    @sum = @numbers.inject(:+)

    @mean = @sum / @count

    # creates an array with the squared diferences
    sqr_dif = []
    @numbers.each do |number|
      sqr_dif.push << (number - @mean) ** 2
    end

    @variance = sqr_dif.inject(:+) / sqr_dif.length

    @standard_deviation = @variance ** 0.5

    mode_count = Hash.new(0)
    @sorted_numbers.each { |name| mode_count[name] += 1 }
    mode_count = mode_count.sort_by { |number, count| count }

    @mode = mode_count.last[0]
  end
end
