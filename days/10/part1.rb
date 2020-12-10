#!/usr/bin/env ruby

# AoC 2020
# Day 10
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:to_i).sort
i1 = input[0..-2]
i2 = input[1..-1]

align = []
i2.each.with_index do |v, idx|
  align << v - i1[idx]
end

one = align.count(1)
three = align.count(3) + 1

p one, three
p one * three
