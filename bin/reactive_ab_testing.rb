#!/usr/bin/ruby

require 'ab_testing/ab_test_accumulator'
require 'ab_testing/reactive_console_reader'

puts "Enter labels and double enter for starting AB testing."

labels = []

until (label = gets.chomp).empty?
  labels.push(label)
end

loop do
  label = cmd_get_label
  time = get_time
  data[label].push(time)
end

accumulator.times.each do |label, times|
  puts label, times
  puts
end
