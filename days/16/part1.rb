#!/usr/bin/env ruby

# AoC 2020
# Day 16
# Part 1

raw_types, raw_ticket, raw_nearby = File.read(ARGV[0] || 'input.txt').split("\n\n")

types = raw_types
  .lines
  .map(&:chomp)
  .map { _1.split ?: }
  .map { |k, v| [k, v.split(" or ").map { a, b = _1.split(?-).map(&:to_i); a..b }]}
  .to_h

ticket = raw_ticket.lines.last.chomp.split(?,).map(&:to_i)

nearby = raw_nearby.lines[1..-1].map { |l| l.chomp.split(?,).map(&:to_i) }

# ---

a = (nearby.map do |n|
  n.map do |v|
    (types.map do |name, ranges|
      ranges.map do |r|
        (r.include? v)
      end.any?
    end.any? ? 0: v)
  end.sum
end.sum)

p a
