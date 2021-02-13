module AbTesting
  module StatisticsHelper

    def mean(array)
      array.sum / array.length.to_f
    end

    def variance(array)
      mean = mean(array)
      sum = array.inject(0) { |accum, e| accum + (e - mean) ** 2 }
      sum / array.length.to_f
    end

    def standard_deviation(array)
      Math.sqrt(variance(array))
    end

    def median(array)
      raise ArgumentError if array.empty?
      array = array.sort
      middle_index = array.size / 2
      if array.size % 2 == 0
        mean(array[middle_index - 1..middle_index])
      else
        array[middle_index]
      end
    end

    def summary
      @times.collect do |label, times|
        if times.empty?
          ''
        else
          median(@times)
        end
      end
    end
  end
end
