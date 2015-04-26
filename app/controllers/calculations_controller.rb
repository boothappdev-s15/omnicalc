class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    character_length=  @text.length
    @character_count_with_spaces = character_length.to_s

    space= @text.count " "
    @character_count_without_spaces = (character_length - space).to_s

    no_of_words=@text.split.size
    @word_count = no_of_words.to_s

n=0
# That wierd symbol in the brackets removes the effect of symbols
    @text.split(/\W+/).each do |word|
if word.downcase == @special_word.downcase
    n+=1
end
end
    @occurrences = n.to_s
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
    months=@years*12
    apr=@apr/1200
    monthly_payment=(apr + (apr/ (((1+apr)**months)- 1)))*@principal
    @monthly_payment =  monthly_payment.to_s
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
    @hours = @minutes/60
    @days = (@hours/24).round(3)
    @weeks = (@days/7).round(2)
    @years = (@days/365).round(2)
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

    even=@count%2
    if even != 0
        median= @numbers[(@count-1)/2]
    else
    if even == 0
median = (@numbers[(@count+1)/2] + @numbers[(((@count+1)/2) -1)])/2
end
end
    @median = median.to_i


    sum=0
    @numbers.each do |lion|
        sum=sum+lion
end

    @sum = sum.to_i

    @mean = (@sum/@count).round(2)

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."
  end
end
