#!/usr/bin/env ruby

# AoC 2020
# Day 5
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp)

p input.map { _1.tr('FBLR', '0101').to_i(2) }.max
