#!/usr/bin/env ruby

# AoC 2020
# Day 2
# Part 1

input = File.readlines(ARGV[0] || 'input.txt')

ins = input.map {
  range, letter1, pass = _1.split
  pw = pass.chars

  low, high = range.split('-').map(&:to_i)
  letter = letter1.split(':')[0]
  
  count = pw.count(letter)

  (low..high).include?(count) ? 1 : 0
}.sum

p ins
