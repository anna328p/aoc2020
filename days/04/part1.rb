#!/usr/bin/env ruby

# AoC 2020
# Day 4
# Part 1

input = File.read(ARGV[0] || 'input.txt')


i = input.split("\n\n").map { _1.split(?\n).join(' ') }.map { _1.split }.map { _1.map { |a| a.split(':') }.to_h }

p i.filter { _1['byr'] && _1['iyr'] && _1['eyr'] && _1['hgt'] && _1['hcl'] && _1['ecl'] && _1['pid']}.size
