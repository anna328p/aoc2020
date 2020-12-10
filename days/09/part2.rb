#!/usr/bin/env ruby

require 'benchmark'

# AoC 2020
# Day 9
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:to_i)

def get_number(input)
  input
    .each_with_index
    .drop(25)
    .map { |v, idx|
      [v,
       input[idx-25..idx]
        .combination(2)
        .map(&:sum)
      ]
    }
    .reject { |v, sums| sums.include? v }
    .map(&:first)
    .first
end

def find_sums(input, num)
  i, j = 0, 0

  loop do
    nums = input[i..j]
    sum = nums.sum
    if sum > num
      i += 1
      next
    elsif sum == num
      return nums.min + nums.max
    end
    j += 1
  end
end

num = get_number input
puts find_sums input, num

Benchmark.bm(20) do |b|
  b.report("part 1 (100 runs):") { 100.times { get_number input } }
  b.report("part 2 (100 runs):") { 100.times { find_sums input, num } }
end
