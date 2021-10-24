require 'ab_testing/ab_test_accumulator'

module AbTesting
  class ConsoleRunner
    def initialize(reader_class)
      @reader_class = reader_class
    end

    def get_labels
      puts "Enter labels and double enter at the end."
      labels = []
      until (label = gets.chomp).empty?
        labels.push(label)
      end
      labels
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

    def parse_time(raw_time)
      Float(raw_time)
    end

    def get_time
      puts "Enter time"
      loop do 
        return nil unless raw_time = gets
        begin
          return parse_time(raw_time)
        rescue ArgumentError
        end
      end
    end

    def output_copiable_times(labels, accumulator)
      puts "Copy the following lines until ### if you want to initialize a follow-up run:"
      puts labels
      puts
      accumulator.times.each do |label, times|
        puts "#{label}: #{times.join(', ')}"
      end
      puts
      puts "###End of copiable part"
    end


    def run
      labels = get_labels
      puts

      reader = @reader_class.new(labels)
      accumulator = AbTesting::AbTestAccumulator.new(labels)

      get_bulk_times(accumulator)

      begin
        loop do
          label = reader.get_label
          break unless label
          time = get_time
          break unless time
          puts
  
          accumulator.push(label, time)
        end
      ensure
        puts
        puts output_copiable_times(labels, accumulator)
        puts accumulator.summary
      end
    end
  end
end
