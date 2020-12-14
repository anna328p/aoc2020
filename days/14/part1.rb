#!/usr/bin/env ruby

# AoC 2020
# Day 14
# Part 1

input = File.readlines(ARGV[0] || 'input.txt')
  .map(&:chomp)
  .map { _1.split ' = ' }
  .map { |k, v|
    if k.start_with? 'mem'
      a = :mem
      b = k.split ?[
      c = b[1].to_i
      [a, c, v.to_i]
    else
      [:mask, 0, v]
    end
  }

cur_mask = "X"*36
mem = []

input.each do |op, addr, val|
  case op
  when :mask
    cur_mask = val
  when :mem
    nm = val.to_s(2).rjust(36, ?0).chars
    mbits = cur_mask.chars

    res = []
    nm.zip(mbits) { |bit, mask|
      res << ((mask == 'X') ? bit : mask)
    }

    newmem = res.join.to_i(2)
    mem[addr] = newmem
  end
end

p mem.reject(&:nil?).sum
