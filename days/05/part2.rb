#!/usr/bin/env ruby

# AoC 2020
# Day 5
# Part 2

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp)

ids = input.map { _1.tr('FBLR', '0101').to_i(2) }

min = ids.min
max = ids.max
p (min..max).filter { !(ids.include?(_1)) && ids.include?(_1 - 1) && ids.include?(_1 + 1) }
