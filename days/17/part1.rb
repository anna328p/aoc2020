#!/usr/bin/env ruby

require 'set'

# AoC 2020
# Day 17
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp).map { _1.chars.map { |c| c == ?# } }

a = Set.new

input.each_with_index do |row, y|
  row.each_with_index do |val, x|
    if val
      a << [0, y, x]
    end
  end
end

def surr_coords z, y, x
  res = []
  (-1..1).each do |dz|
    (-1..1).each do |dy|
      (-1..1).each do |dx|
        if [dz, dy, dx] != [0, 0, 0]
          res << [z + dz, y + dy, x + dx]
        end
      end
    end
  end

  res
end

def surroundings_count input, z, y, x
  sc = surr_coords z, y, x
  sc.map { input.include? _1 }.select { _1 }.size
end

old = a.dup

6.times do |iter|
  cs = Set.new
  a = Set.new

  old.each do |az, ay, ax|
    around = surr_coords(az, ay, ax)
    around.each { cs << _1 }
  end

  cs.each do |z, y, x|
    s = surroundings_count(old, z, y, x)

    cell = old.include? [z, y, x]

    if (cell ? (s == 2 || s == 3) : (s == 3))
      a << [z, y, x]
    end
  end

  old = a.dup
end

p a.size
