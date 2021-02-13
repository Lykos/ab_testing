module AbTesting
  class ReactiveConsoleReader

    def this.get_labels
      puts "Enter labels and double enter at the end."
      labels = []
      until (label = gets.chomp).empty?
        labels.push(label)
      end
      labels
    end

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

    def get_time
      puts "Enter time"
      return nil unless raw_time = gets
      Float(raw_time)
    end
  end
end
