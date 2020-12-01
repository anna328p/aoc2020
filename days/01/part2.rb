#!/usr/bin/env ruby

# AoC 2020
# Day 1
# Part 2

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map(&:to_i)

p i.combination(3).find { |a, b, c| a + b + c == 2020 }.inject(:*)
