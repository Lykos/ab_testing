module AbTesting
  class ReactiveConsoleReader
    def initialize(labels)
      @labels = labels
    end

    def get_label
      puts "Enter label"
      while raw_label = gets
        label = raw_label.chomp
        return label if @labels.include?(label)
      end
    end
  end
end
