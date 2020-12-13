#!/usr/bin/env ruby

# AoC 2020
# Day 13
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp)

ts = input[0].to_i
buses = input[1].split(?,).reject { _1 == ?x }.map(&:to_i)

curbus = buses.dup
buses.each.with_index do |bus, idx|
  p bus
  temp = 0
  temp += bus until temp >= ts
  p temp
  curbus[idx] = temp
end

m = curbus.min
i = curbus.index(m)
p buses[i] * (m - ts)
