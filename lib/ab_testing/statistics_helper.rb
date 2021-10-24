require 'ab_testing/t_test_table'

module AbTesting
  module StatisticsHelper
    include TTestTable

    class StatsInput
      def initialize(label, array)
        @label = label
        @array = array
      end

      attr_reader :label, :array

      def length
        @array.length
      end

      def empty?
        @array.empty?
      end

      def sum
        @sum ||= @array.sum
      end

      def mean
        @mean ||= sum / length.to_f
      end

      def variance
        @variance ||= @array.inject(0) { |accum, e| accum + (e - mean) ** 2 } / (length.to_f - 1)
      end

      def standard_deviation
        @standard_deviation ||= Math.sqrt(variance)
      end

      def standard_error
        @standard_error ||= variance / length.to_f
      end

      def median
        @median ||=
          begin
            raise ArgumentError if array.empty?
            array = @array.sort
            middle_index = array.size / 2
            if array.size % 2 == 0
              (array[middle_index - 1] + array[middle_index]) / 2.0
            else
              array[middle_index]
            end
          end
      end
    end

    def welch_t_test_bigger(a, b, alpha)
      raise TypeError unless a.is_a?(StatsInput) && b.is_a?(StatsInput)
      s = Math.sqrt(a.standard_error + b.standard_error)
      t_calculated = (a.mean - b.mean) / s
      nu = (a.standard_error + b.standard_error) ** 2 / (a.standard_error ** 2 / (a.length - 1) + b.standard_error ** 2 / (b.length - 1))
      t_calculated > t(alpha, nu)
    end
  end
end
