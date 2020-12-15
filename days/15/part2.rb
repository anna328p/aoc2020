#!/usr/bin/env ruby

require 'set'

# AoC 2020
# Day 15
# Part 2

input = File.read(ARGV[0] || 'input.txt').split(',').map(&:to_i)

spoken = Set.new
indices = Hash.new nil
counts = Hash.new 0
index = 0
l = 0

loop do
  num = 0

  if (index < input.size)
    num = input[index]
  elsif indices[l] && counts[num] > 1
    # age
    num = index - indices[l]
  else
    num = 0
  end

  spoken << num
  indices[l] = index
  counts[num] += 1
  l = num

  index += 1

  STDERR.puts "[iteration] #{index.to_s.rjust 9}" if index % 100_000 == 0
  break if index >= 30_000_000
end

p l
