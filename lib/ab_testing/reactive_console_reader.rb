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

    def get_time
      puts "Enter time"
      return nil unless raw_time = gets
      Float(raw_time)
    end

    def add_time(label, time)
      raise ArgumentError, "Added time #{time} for non-existing label #{label}." unless times.include?(label)
      @times[label].push(time)
    end
  end
end
