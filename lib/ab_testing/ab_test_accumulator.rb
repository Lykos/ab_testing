require_relative 'statistics_helper'

module AbTesting
  class AbTestAccumulator
    def initialize(labels)
      @times = labels.map { |l| [l, []] }.to_h
    end

    attr_reader :times

    include StatisticsHelper

    def push(label, time)
      raise ArgumentError, "Added time #{time} for non-existing label #{label}." unless times.include?(label)
      @times[label].push(time)
    end

    def summary
      inputs = @times.collect { |label, times| StatsInput.new(label, times) }.sort_by { |a| a.mean }
      general_summary(inputs).join("\n") + "\n" + t_test_summary(inputs).join("\n")
    end

    def general_summary(inputs)
      inputs.collect do |input|
        next if input.empty?
        "#{input.label}: N: #{input.length}; Mean: #{input.mean.round(2)}; Median: #{input.median.round(2)}; Standard Deviation: #{input.standard_deviation.round(2)}"
      end.compact
    end

    ALPHAS = [0.99, 0.95, 0.75]

    def t_test_summary(inputs)
      inputs.combination(2).collect do |a, b|
        max_alpha = ALPHAS.select { |alpha| welch_t_test_bigger(b, a, alpha) }.max
        "#{b.label} > #{a.label} with confidence #{max_alpha * 100}%" if max_alpha
      end.compact
    end
  end
end
