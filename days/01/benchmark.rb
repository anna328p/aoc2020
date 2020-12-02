#!/usr/bin/env ruby

require 'benchmark'

# AoC 2020
# Day 1
# Part 2

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map(&:to_i)

a = 0

Benchmark.bm do |x|
  x.report("part 1") { a = i.combination(2).find { _1.sum == 2020 }.inject(:*) }
  x.report("part 2") { a = i.combination(3).find { _1.sum == 2020 }.inject(:*) }
end

p a
