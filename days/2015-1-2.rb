#!/usr/bin/env ruby

# AoC 2020
# Day 2
# Part 2

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map { _1.split('x').map(&:to_i) }

p i.map { |x, y, z| 
  a = [2*x+2*y, 2*y+2*z, 2*x+2*z]; a.min + x * y * z }.sum


