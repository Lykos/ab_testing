#!/usr/bin/ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'ab_testing/console_runner'
require 'ab_testing/sampled_console_reader'

AbTesting::ConsoleRunner.new(AbTesting::SampledConsoleReader).run
