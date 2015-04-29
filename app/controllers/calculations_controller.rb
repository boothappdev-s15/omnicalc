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
    @character_count_without_spaces = @text.split(' ').join('').length

    @word_count = @text.split(' ').length

    def counter(wrds, special_word)
      downcased_special_word = special_word.downcase
      stripped_words = wrds.scan(/[a-zA-z \d]/).join

      list_of_words = stripped_words.downcase.split(' ')

      tally = 0
      list_of_words.each do |word|
        # logic to tally or not tally
        # tally if word matches special word
        # tally = tally + 1

        if word == special_word
          tally = tally + 1
        end
      end

      return tally
    end


    @occurrences =  counter(@text,@special_word)


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
    def loancalc(apr,years,principal)
        apr = apr/(100.0*12)
        num = apr * principal
        den = 1.0-((1.0+apr)**(-years*12))
       return num/den
    end

    @monthly_payment = loancalc(@apr,@years,@principal)



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
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @months = @weeks/4
    @years = @weeks/52
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================



    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

   def med (count,sorted)
        if count%2 == 0
           return (sorted[count/2]+sorted[count/2 - 1])/2

        else
           return sorted[count/2]
        end
    end

    @median = med(@count,@sorted_numbers)

    @sum = @numbers.sum

    @mean = @sum/@count

    def var(numbers,mean,count)
        total = 0
        numbers.each do |diff|
           sqdif =  (diff - mean)**2
            total = total + sqdif
        end
        return total/count
    end


    @variance = var(@numbers,@mean,@count)


    @standard_deviation = @variance**(1.0/2)



def mode(numbers)
    newlist = Hash.new(0)

    numbers.each do |i|
      newlist[i] += 1
    end

    modereturn = []

    newlist.each do |k,v|
      if v == newlist.values.max
        modereturn.push k
      end
    end


    return modereturn[0]

end

    @mode = mode(@numbers)
  end

end
