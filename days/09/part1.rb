#!/usr/bin/env ruby

# AoC 2020
# Day 9
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:to_i)

p input
  .each_with_index
  .drop(25)
  .map { |v, idx|
    [v,
     input[idx-25..idx]
      .combination(2)
      .map(&:sum)
    ]
  }
  .reject { |v, sums| sums.include? v }
  .map(&:first)
  .first
