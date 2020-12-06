#!/usr/bin/env ruby

require 'set'

# AoC 2020
# Day 6
# Part 2

input = File.read(ARGV[0] || 'input.txt')

i = input.split("\n\n").map { |a| a.split.map { Set.new _1.chomp.chars } }

p i.map { _1.inject(&:&).size }.sum
