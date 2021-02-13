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
      @times.collect do |label, times|
        next if times.empty?
        "#{label}: N: #{times.length}; Mean: #{mean(times).round(2)}; Median: #{median(times).round(2)}; Standard Deviation: #{standard_deviation(times).round(2)}"
      end.compact.join("\n")
    end
  end
end
