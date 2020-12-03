#!/usr/bin/env ruby

# AoC 2020
# Day 3
# Part 1

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map { (_1.chomp * _1.size * 3).chars }

trees = 0
i.each_with_index { |row, idx|
  if row[3*idx] == '#'
    trees += 1;
  end
}

p trees
