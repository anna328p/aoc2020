#!/usr/bin/env ruby

# AoC 2020
# Day 24
# Part 1

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
    when :e
      x += 1
    when :w
      x -= 1
    when :ne
      y += 1
      x += 1
    when :nw
      y += 1
    when :se
      y -= 1
    when :sw
      y -= 1 
      x -= 1
    end
  end

  [x, y]
end

input.each do
  pos = walk _1
  tiles[pos] = (tiles[pos] == :white) ? :black : :white
end

p tiles.values.count(:black)
