#!/usr/bin/env ruby

# AoC 2020
# Day 7
# Part 2

input = File.readlines(ARGV[0] || 'input.txt').map(&:split).map { |a, b| [a.to_sym, b.to_i]}


def try_run inp
  ip = 0
  visited = []

  acc = 0

  loop do
    visited << ip
    if visited != visited.uniq
      return false
    end

    if ip >= inp.size
      return acc
    end

    ins, val = inp[ip]
    case ins
    when :acc
      acc += val
    when :jmp
      ip += val - 1
    when :nop
    end

    ip += 1
  end
end

input.each.with_index do |_, idx|
  ins, val = input[idx]

  old_ins = ins
  if ins == :nop
    input[idx][0] = :jmp
  elsif ins == :jmp
    input[idx][0] = :nop
  end

  if (a = try_run(input))
    puts a
    exit 0
  else
    input[idx][0] = old_ins
  end
end
