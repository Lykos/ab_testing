module AbTesting
  class SampledConsoleReader
    def initialize(labels)
      @labels = labels
    end

    def get_label
      sample = @labels.sample
      puts sample
      sample
    end
  end
end
