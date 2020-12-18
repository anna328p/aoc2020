#!/usr/bin/env ruby

require './RPNExpression.rb'

# AoC 2020
# Day 18
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp).map {
  _1.gsub("(", " ( ").gsub(")", " ) ")
}

p input.map { |i| RPNExpression.from_infix(i).eval }.sum
