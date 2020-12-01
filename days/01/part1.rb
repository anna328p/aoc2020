#!/usr/bin/env ruby

# AoC 2020
# Day 1
# Part 1

input = File.readlines(ARGV[0] || 'input.txt')


i = input.map(&:to_i)

s = i.map do |a|
  i.flat_map { |b| a + b == 2020 ? [a, b] : nil }.reject(&:nil?)
end.reject { |s| s == []}

p s[0].inject(:*)
