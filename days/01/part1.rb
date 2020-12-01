#!/usr/bin/env ruby

# AoC 2020
# Day 1
# Part 1

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map(&:to_i)

p i.combination(2).find { |a| a.sum == 2020 }.inject(:*)
