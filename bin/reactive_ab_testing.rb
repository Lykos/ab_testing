#!/usr/bin/ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'ab_testing/console_runner'
require 'ab_testing/reactive_console_reader'

puts "This AB Testing tool assumes that you have an external source of random samples."

AbTesting::ConsoleRunner.new(AbTesting::ReactiveConsoleReader).run
