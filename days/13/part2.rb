#!/usr/bin/env ruby

# AoC 2020
# Day 13
# Part 2

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp)

buses = input[1].split(?,).map(&:to_i)

l = 'a'
buses.each.with_index do |bus, idx|
  if bus != 0
    print "#{bus}#{l} = t + #{idx}, "
    l = (l.ord + 1).chr
  end
end

puts
