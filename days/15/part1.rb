#!/usr/bin/env ruby

# AoC 2020
# Day 15
# Part 1

input = File.read(ARGV[0] || 'input.txt').split(',').map(&:to_i)


spoken = []
index = 0

loop do
  num = 0
  l = spoken.last

  if (index < input.size)
    num = input[index]
  elsif spoken.index(l) != (spoken.size - 1)
    num = spoken[0..-2].reverse.index(l) + 1
  else
    num = 0
  end

  spoken << num
  index += 1
  break if index >= 2020
end

p spoken.last
