#!/usr/bin/env ruby

# AoC 2020
# Day 2
# Part 1

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map { _1.split('x').map(&:to_i) }

p i.map { |x, y, z| a = [2*x*y, 2*y*z, 2*x*z]; a.sum + a.min/2 }.sum
