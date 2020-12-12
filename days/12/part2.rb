#!/usr/bin/env ruby

# AoC 2020
# Day 12
# Part 2

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp).map { c = _1.chars; [c[0].to_sym, c[1..-1].join.to_i]}

def cw x, y
  return y, -x
end

def ccw x, y
  return -y, x
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
wx = 10
wy = 1

x = 0
y = 0

input.each do |act, val|
  num = val / 90

  case act
  when :N, :S, :E, :W
    d = to_delta act
    wx += d[0] * val
    wy += d[1] * val
  when :L
    num.times { wx, wy = ccw wx, wy }
  when :R
    num.times { wx, wy = cw wx, wy }
  when :F
    x += wx * val
    y += wy * val
  end
end

p x.abs + y.abs
