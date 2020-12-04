#!/usr/bin/env ruby

# AoC 2020
# Day 4
# Part 2

input = File.read(ARGV[0] || 'input.txt')

i = input.split("\n\n").map {
  _1.split(?\n).join(' ')
}.map { _1.split }.map {
  _1.map { |a|
    a.split(':')
  }.to_h
}

p i.filter { 
  hgt = _1['hgt'] && _1['hgt'][0..-3].to_i;
  (1920..2002).include?(_1['byr'].to_i) &&
  (2010..2020).include?(_1['iyr'].to_i) &&
  (2020..2030).include?(_1['eyr'].to_i) && 
  hgt &&
  %w(cm in).include?(_1['hgt'][-2..-1]) &&
  (_1['hgt'] && _1['hgt'][-2..-1] == 'cm' ?
   (150..193).include?(hgt) :
   (59..76).include?(hgt)
  ) &&
  /^#[0-9a-f]{6}$/.match?(_1['hcl']) &&
  %w(amb blu brn gry grn hzl oth).include?(_1['ecl']) &&
  /^\d{9}$/.match?(_1['pid'])}.size
