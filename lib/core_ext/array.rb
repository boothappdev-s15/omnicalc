class Array

  def mode
    mode_array = []
    counter = Hash.new(0)
    self.each do |i|
      counter[i] += 1
    end

    counter.each do |k, v|
      if v==counter.values.max
        mode_array << k
      end
    end

    # if mode_array.count > 1
    #   @mode = mode_array
    # else
    #   @mode = mode_array.first
    # end
    # this code produces the same results as the line below

    mode_array.count > 1 ? mode_array : mode_array.first
  end

end
