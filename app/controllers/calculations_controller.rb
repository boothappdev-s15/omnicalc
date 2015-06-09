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

@character_count_without_spaces = @character_count_with_spaces - @text.count(" ")

@word_count = @text.split.count

@occurrences = @text.scan(@special_word).length
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

    r = @apr/1200
    m = @years*12

    @monthly_payment = @principal*((r*(1+r)**m)/((1+r)**m-1))
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
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365.25
end

def mean(list_of_numbers)
  # Let's re-use the work we did above in the sum method
  list_mean = sum(list_of_numbers) / list_of_numbers.count
  return list_mean
end

def sum(list_of_numbers)
  running_total = 0
  list_of_numbers.each do |number|
    running_total = running_total + number
end
return running_total
end

def variance(list_of_numbers)
  # Let's re-use the work we did above in the mean method

  list_mean = mean(list_of_numbers)
  sq_differences = []

  list_of_numbers.each do |number|
    sq_differences.push (list_mean - number)**2
end

list_variance = mean(sq_differences)

return list_variance

end

def standard_deviation(list_of_numbers)

  list_sd = variance(list_of_numbers)**0.5
  return list_sd
end

def median(list_of_numbers)

    list_of_numbers = list_of_numbers.sort

    m_pos = list_of_numbers.size / 2
    return list_of_numbers.size % 2 == 1 ? list_of_numbers[m_pos] : mean(list_of_numbers[m_pos-1..m_pos])

end

def modes(list_of_numbers)

    mode_counter = Hash.new(0)

    list_of_numbers.each do |i|
        mode_counter[i] = mode_counter[i] + 1
    end

    mode_array = []

    mode_counter.each do |k, v|
        if v == mode_counter.values.max
          mode_array << k
      end
  end

  return mode_array

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

    @sum = sum(@numbers)

    @mean = mean(@numbers)

    @variance = variance(@numbers)

    @standard_deviation = standard_deviation(@numbers)

    @mode = modes(@numbers)
end
end
