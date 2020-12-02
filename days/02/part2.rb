#!/usr/bin/env ruby

# AoC 2020
# Day 2
# Part 2

input = File.readlines(ARGV[0] || 'input.txt')

ins = input.map {
  range, letter1, pass = _1.split
  pw = pass.chars

  low, high = range.split('-').map(&:to_i)
  letter = letter1.split(':')[0]
  
  valid = (pw[low-1] == letter) ^ (pw[high-1] == letter)
  valid ? 1 : 0
}.sum

p ins
