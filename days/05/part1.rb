#!/usr/bin/env ruby

# AoC 2020
# Day 5
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp)

i = input.map { [ _1[0..6], _1[-3..-1] ] }

p i.map { |row, col|
  high = 0
  low = 127
  row.chars.each do |c|
    temp = (low - high + 1) / 2
    case c
    when 'F', 'L'
      low -= temp
    when 'B', 'R'
      high += temp
    end
  end
  r = high


  high = 0
  low = 7
  col.chars.each do |c|
    temp = (low - high + 1) / 2
    case c
    when 'R'
      high += temp
    when 'L'
      low -= temp
    end
  end
  c = high

  r * 8 + c
}.max
