#!/usr/bin/env ruby

# AoC 2020
# Day 3
# Part 2

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map { (_1.chomp * _1.size * 7).chars }

def trees(i, spacing, x = 1)
  trees = 0
  i.each_with_index { |row, idx|
    next if idx % x == 1
    if row[idx*spacing] == '#'
      trees += 1;
    end
  }
  return trees;
end


a = trees(i, 1)
b = trees(i, 3)
c = trees(i, 5)
d = trees(i, 7)
e = trees(i, 0.5, 2)
p a * b * c * d * e
