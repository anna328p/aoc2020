#!/usr/bin/env ruby

# AoC 2020
# Day 14
# Part 2

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
mem = Hash.new { 0 }

input.each do |op, addr, val|
  case op
  when :mask
    cur_mask = val
  when :mem
    m = []

    cur_mask.chars.each.with_index do |mc, idx|
      if mc == 'X'
        m << idx
      end
    end

    (0..(2 ** m.size)).each do |comb|
      na = addr.to_s(2).rjust(36, ?0).chars

      bits = comb.to_s(2).rjust(m.size, ?0)

      m.each.with_index do |bit, idx|
        na[bit] = bits[idx]
      end

      na = na.map.with_index do |bit, idx|
        (cur_mask.chars[idx] == ?1) ? ?1 : bit
      end
      mem[na.join.to_i(2)] = val
    end
  end
end

p mem.values.reject(&:nil?).sum
