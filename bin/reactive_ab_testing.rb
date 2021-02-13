#!/usr/bin/ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'ab_testing/ab_test_accumulator'
require 'ab_testing/reactive_console_reader'

puts "This AB Testing tool assumes that you have an external source of random samples."

labels = AbTesting::ReactiveConsoleReader.get_labels
puts

reader = AbTesting::ReactiveConsoleReader.new(labels)
accumulator = AbTesting::AbTestAccumulator.new(labels)

loop do
  label = reader.get_label
  break unless label
  time = reader.get_time
  break unless time
  
  accumulator.push(label, time)
end

puts

accumulator.times.each do |label, times|
  puts label, times
  puts
end
