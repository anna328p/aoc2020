#!/usr/bin/env ruby

# AoC 2020
# Day 11
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp).map(&:chars)

  puts input.map(&:join).join(?\n)

def surroundings input, x, y
  xmin = 0
  xmax = input[0].size - 1

  ymin = 0
  ymax = input.size - 1

  [
    y > ymin && x > xmin && input[y-1][x-1],
    y > ymin &&             input[y-1][x],
    y > ymin && x < xmax && input[y-1][x+1],

    x > xmin && input[y][x-1],

    x < xmax && input[y][x+1],

    y < ymax && x > xmin && input[y+1][x-1],
    y < ymax &&             input[y+1][x],
    y < ymax && x < xmax && input[y+1][x+1]
  ].select { _1 }
end

p surroundings input, 0, 0
p surroundings input, 8, 7

old_in = input.map(&:dup)

1.step do |a|
  input.each.with_index do |row, y|
    row.each.with_index do |seat, x|
      surr = surroundings old_in, x, y

      no_adj = surr.count(?#) == 0
      crowded = surr.count(?#) >= 4

      if (seat == ?L && no_adj)
        input[y][x] = ?#
      elsif (seat == ?# && crowded)
        input[y][x] = ?L
      end
    end
  end

  puts old_in.map(&:join).join(?\n)

  if (a > 0 && old_in == input)
    count = input.map { _1.count ?# }.sum
    p count
    break
  end

  old_in = input.map(&:dup)
  puts
end
