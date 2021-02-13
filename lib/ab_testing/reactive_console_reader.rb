module AbTesting
  class ReactiveConsoleReader

    def self.get_labels
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

    def get_bulk_times(accumulator)
      puts "Optionally copy summarized data from previous runs and double enter at the end."
      until (row = gets.chomp).empty?
        label, raw_times = row.split(': ')
        next unless raw_times
        times = raw_times.split(', ').map { |raw_time| parse_time(raw_time) }
        times.each { |time| accumulator.push(label, time) }
      end
    end

    def output_copiable_times(accumulator)
      puts "Copy the following lines until ### if you want to initialize a follow-up run:"
      puts @labels
      puts
      accumulator.times.each do |label, times|
        puts "#{label}: #{times.join(', ')}"
      end
      puts
      puts "###End of copiable part"
    end

    def get_label
      puts "Enter label"
      while raw_label = gets
        label = raw_label.chomp
        return label if @labels.include?(label)
      end
    end

    def parse_time(raw_time)
      Float(raw_time)
    end

    def get_time
      puts "Enter time"
      return nil unless raw_time = gets
      parse_time(raw_time)
    end
  end
end
