#!/usr/bin/env ruby

require 'set'

# AoC 2020
# Day 24
# Part 2

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp).map { |line|
  dirs = []
  pos = 0
  until pos >= line.size
    a = line[pos]
    case a
    when 'e', 'w'
      dirs << a.to_sym
    when 'n', 's'
      pos += 1
      b = line[pos]
      dirs << "#{a}#{b}".to_sym
    end

    pos += 1
  end

  dirs
}

tiles = Hash.new :white

def walk dirs
  x = 0
  y = 0
  
  dirs.each do
    case _1
    when :w
      x -= 1
    when :e
      x += 1
    when :nw
      y -= 1
    when :ne
      x += 1
      y -= 1
    when :sw
      x -= 1
      y += 1
    when :se
      y += 1
    end
  end

  [x, y]
end

tiles = Set.new

input.each do
  pos = walk _1
  if tiles.include? pos
    tiles.delete pos
  else
    tiles.add pos
  end
end

# --------------------------------------- #

def surroundings coords
  x, y = coords
  [
    [-1, 0],
    [1, 0],
    [0, -1],
    [1, -1],
    [-1, 1],
    [0, 1]
  ].map { |dx, dy| [x + dx, y + dy] }
end

def neighbors tiles, coords
  surroundings(coords).map { tiles.include?(_1) ? :black : :white }
end

old = tiles.dup
100.times do
  old.each do |coords|
    surr = surroundings(coords) + [coords]

    surr.each do |tile|
      n = neighbors(old, tile)
      c = n.count(:black)

      if (c == 0) || (c > 2)
        tiles.delete tile
      elsif c == 2
        tiles.add tile
      end
    end
  end

  old = tiles.dup
end

p tiles.size
