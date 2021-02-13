module AbTesting
  class AbTestAccumulator
    def initialize(labels)
      @times = labels.map { |l| [l, []] }.to_h
    end

    attr_reader :times

    def push(label, time)
      raise ArgumentError, "Added time #{time} for non-existing label #{label}." unless times.include?(label)
      @times[label].push(time)
    end
  end
end
