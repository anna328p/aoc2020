#!/usr/bin/env ruby

# AoC 2020
# Day 23
# Part 1

cups = File.read(ARGV[0] || 'input.txt').chomp.chars.map(&:to_i)

num = ARGV[1].to_i || 100

min, max = cups.minmax

pos = 0
num.times do |round|
  cur = cups[pos]

  puts "round #{round}"

  p cups

  tmp = cups.shift
  picked = cups.shift(3)
  cups.unshift tmp

  puts "picked #{picked}"

  dest = cur - 1

  idx = nil
  until idx
    idx = cups.index dest
    if !idx
      dest -= 1
      if dest < min
        dest = max
      end
    end
  end

  puts "destination #{dest}"

  cups = cups.insert(idx + 1, picked).flatten.rotate
  p cups
  puts
end

cups.rotate! until cups[0] == 1

p cups[1..-1].map(&:to_s).join
