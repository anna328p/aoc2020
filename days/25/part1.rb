#!/usr/bin/env ruby

# AoC 2020
# Day 25
# Part 1

cpub, dpub = File.readlines(ARGV[0] || 'input.txt').map(&:to_i)


def transform subject, loopsize
  modulus = 20201227

  return subject.pow(loopsize, modulus)
end

card_pub = nil
cardloop = 0
while (card_pub != cpub)
  cardloop += 1
  card_pub = transform(7, cardloop)
end

door_pub = nil
doorloop = 0
while (door_pub != dpub)
  doorloop += 1
  door_pub = transform(7, doorloop)
end

p transform(cpub, doorloop)
