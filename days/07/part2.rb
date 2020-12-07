#!/usr/bin/env ruby

# AoC 2020
# Day 7
# Part 2

input = File.readlines(ARGV[0] || 'input.txt')

i = input.map { _1.split((" contain ")) }
  .map { |a, b| [a, *b.split(', ')] }
  .map {
    _1.map { |a| a.gsub(/ bag.*/, '') }
  }.map { |a, *b|
    [a, b.map {
      a, *w = _1.split
      [w.join(' '), a.to_i]
    }.to_h]
  }.to_h

def count_bags i, q
  i[q]&.map { |k, v| v + v * count_bags(i, k) }&.sum || 1
end

p count_bags i, 'shiny gold'
