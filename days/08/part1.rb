#!/usr/bin/env ruby

# AoC 2020
# Day 7
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:split).map { |a, b| [a.to_sym, b.to_i]}

ip = 0
visited = []

acc = 0

size = input.size

loop do
  visited << ip
  if visited != visited.uniq
    puts acc
    exit 0
  end


  ins, val = input[ip]
  case ins
  when :acc
    acc += val
  when :jmp
    ip += val - 1
  when :nop
  end

  ip += 1
end
