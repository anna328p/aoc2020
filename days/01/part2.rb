#!/usr/bin/env ruby

# AoC 2020
# Day 1
# Part 2

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map(&:to_i)

s = i.map do |a|
  i.map do |c|
    i.flat_map { |b| a + b + c == 2020 ? [a, b, c] : nil }.reject(&:nil?)
  end.reject { |s| s == []}
end.reject { |s| s == []}

p s[0][0].inject(:*)
