#!/usr/bin/env ruby

require 'set'

# AoC 2020
# Day 7
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp)

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

def has i, color, q
  i[color]&.keys&.any? { _1 == q || has(i, _1, q) }
end

p i.filter { has(i, _1, 'shiny gold') }.size
