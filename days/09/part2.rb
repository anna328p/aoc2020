#!/usr/bin/env ruby

# AoC 2020
# Day 9
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:to_i)


num = nil;
input.each.with_index do |v, idx|
  if idx < 25
    next
  end

  sums = input[(idx-25)..(idx)].combination(2).map(&:sum)
  if !sums.include? v
    num = v
    break
  end
end


(0..input.length).each do |i|
  (i..input.length).each do |j|
    nums = input[i..j]
    sum = nums.sum
    if sum == num
      puts nums.min + nums.max
      exit 0
    end
end
end
