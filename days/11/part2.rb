#!/usr/bin/env ruby

# AoC 2020
# Day 11
# Part 2

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp).map(&:chars)

def walk_dir input, x, y, dx, dy
  xmin = 0
  xmax = input[0].size - 1

  ymin = 0
  ymax = input.size - 1

  return nil if [dx, dy] == [0, 0]

  loop do
    x += dx
    y += dy

    if x < xmin || y < ymin || x > xmax || y > ymax
      return nil
    end

    cell = input[y][x]
    if cell == ?# || cell == ?L
        return cell
    end
  end
end

def surroundings input, x, y
  [
    walk_dir(input, x, y, -1, -1),
    walk_dir(input, x, y,  0, -1),
    walk_dir(input, x, y,  1, -1),

    walk_dir(input, x, y, -1,  0),
    walk_dir(input, x, y,  1,  0),

    walk_dir(input, x, y, -1,  1),
    walk_dir(input, x, y,  0,  1),
    walk_dir(input, x, y,  1,  1),
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
      crowded = surr.count(?#) >= 5

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
