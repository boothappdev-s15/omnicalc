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

    @character_count_without_spaces = @text.delete(" ").length

    @word_count = @text.split.size

    #@occurrences = @text.count(@special_word) # this says the special word is the seventh element
    @occurrences = @text.scan(@special_word).count # this says the special word is the seventh element

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
   # @monthly_payment = loan_payment(@apr,@years,@principal)
     monrate = @apr/100/12
     n = @years*12
     @monthly_payment = (monrate*@principal)/(1-((1+monrate)**-n))
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
    @years = @weeks/52.17857
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.size

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

      def median
        sorted = @numbers.sort
        mid = (sorted.length - 1) / 2.0
        (sorted[mid.floor] + sorted[mid.ceil]) / 2.0
      end
   
    @median = median

    @sum = @numbers.sum

    @mean = @sum/@count

         def variance
            rt = 0
            @numbers.each do |apple|
                temp = (apple - @mean)**2
                rt = rt + temp
            end
            variance=rt/@count
        end

    @variance = variance

    @standard_deviation = @variance**0.5
       
     # #below outputs freq data 
     # def score
     #    hash = Hash.new(0)   
     #    #@numbers.each{|key|hash[key] +=1} 
     #    @numbers.each{|key|hash[key] +=1}.max
     #    hash
     # end
    
    def test 
    arr = @numbers
    freq = arr.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    arr.max_by { |v| freq[v] }
    end
    
    @mode = test # looks like ruby  picks one of many modes
  end
end
