#!/usr/bin/env ruby

require 'matrix'

# AoC 2020
# Day 20
# Part 1

input = File.read(ARGV[0] || 'input.txt').split("\n\n").map { |i|
  a, *b = i.lines

  [a.split.last.to_i, b.map { _1.chomp.chars } ]
}.to_h


def borders(view)
  t = view.transpose

  [
    view[0], view[-1], t[0], t[-1],
    view[0].reverse, view[-1].reverse, t[0].reverse, t[-1].reverse
  ]
end

grid = {}
remaining = input.dup

kf = remaining.keys.first
grid[[0, 0]] = [kf, remaining[kf]]
remaining.delete(kf)

def cs a, b
  a.zip(b).map(&:sum)
end

def transform array, matrix
  res = {}

  array.each_with_index do |row, y|
    row.each_with_index do |elem, x|
      nm = (matrix * Matrix[[x], [-y]])
      nx, ny = nm.to_a.map(&:first)

      res[[nx, -ny]] = elem
    end
  end

  min_x, max_x = res.keys.map(&:first).minmax
  min_y, max_y = res.keys.map(&:last).minmax

  size_x = max_x - min_x + 1
  size_y = max_y - min_y + 1

  arr = Array.new(size_y) { Array.new(size_x) }

  res.each do |(x, y), elem|
    arr[y - min_y][x - min_x] = elem
  end

  return arr
end

until remaining.empty?
  old_grid = grid.dup
  remaining.each do |rid, rview|
    new_grid = grid.dup
    grid.each do |pos, (id, view)|
      a = borders(view)[0..3]
      b = borders(input[rid])

      common = a & b

      if !common.empty?
        index1 = a.index { common.include? _1 }
        index2 = b.index { common.include? _1 }

        coord = pos

        case index1 % 4
        when 0 # top border
          coord = cs pos, [0, -1]
        when 1 # bottom border
          coord = cs pos, [0, 1]
        when 2 # left border
          coord = cs pos, [-1, 0]
        when 3 # right border
          coord = cs pos, [1, 0]
        end

        next if grid.keys.include? coord

        mx1 = case (index1 % 4)
              when 0
                Matrix[
                  [ 1,  0],
                  [ 0, -1]
                ]
              when 1
                Matrix[
                  [ 1,  0],
                  [ 0,  1]
                ]
              when 2
                Matrix[
                  [ 0,  1],
                  [-1,  0]
                ]
              when 3
                Matrix[
                  [ 0, -1],
                  [-1,  0]
                ]
              end

        mx2 = case index2
              when 0
                Matrix[
                  [ 1,  0],
                  [ 0,  1]
                ]
              when 1
                Matrix[
                  [ 1,  0],
                  [ 0, -1]
                ]
              when 2
                Matrix[
                  [ 0, -1],
                  [-1,  0]
                ]
              when 3
                Matrix[
                  [ 0, -1],
                  [ 1,  0]
                ]
              when 4
                Matrix[
                  [-1,  0],
                  [ 0,  1]
                ]
              when 5
                Matrix[
                  [-1,  0],
                  [ 0, -1]
                ]
              when 6
                Matrix[
                  [ 0,  1],
                  [-1,  0]
                ]
              when 7
                Matrix[
                  [ 0,  1],
                  [ 1,  0]
                ]
              end

        nview = transform(rview, mx1 * mx2)

        new_grid[coord] = [rid, nview]
        remaining.delete(rid)

        grid = new_grid
        break
      end
    end
    grid = new_grid
  end
  break if grid == old_grid
  old_grid = grid
end


gk = grid.keys

min_x = gk.map { _1[0] }.min
max_x = gk.map { _1[0] }.max

min_y = gk.map { _1[1] }.min
max_y = gk.map { _1[1] }.max

p [
  grid[[min_x, min_y]],
  grid[[min_x, max_y]],
  grid[[max_x, min_y]],
  grid[[max_x, max_y]]
].map { |id, _| id }.inject(&:*)
