class ABTestAccumulator
  def initialize(labels)
    @times = labels.map { |l| [l, []] }.to_h
  end

  attr_reader :times

  def add_time(label, time)
    @times[label].push(time)
  end
end
