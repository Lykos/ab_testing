module AbTesting
  class SampledConsoleReader
    def initialize(labels)
      @labels = labels
    end

    def get_label
      @labels.sample
    end
  end
end
