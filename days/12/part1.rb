#!/usr/bin/env ruby

# AoC 2020
# Day 12
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp).map { c = _1.chars; [c[0].to_sym, c[1..-1].join.to_i]}

def cw dir
  dirs = [ :N, :E, :S, :W ]

  dirs[dirs.index(dir) + 1] || :N
end

def ccw dir
  dirs = [ :N, :E, :S, :W ]

  dirs[dirs.index(dir) - 1]
end

def to_delta dir
  case dir
  when :N
    [0, 1]
  when :S
    [0, -1]
  when :E
    [1, 0]
  when :W
    [-1, 0]
  end
end

dir = :E
x = 0
y = 0

input.each do |act, val|
  num = val / 90

  case act
  when :N, :S, :E, :W
    d = to_delta act
    x += d[0] * val
    y += d[1] * val
  when :L
    num.times { dir = ccw dir }
  when :R
    num.times { dir = cw dir }
  when :F
    d = to_delta dir
    x += d[0] * val
    y += d[1] * val
  end
end

p x.abs + y.abs
