#!/usr/bin/env ruby

# AoC 2020
# Day 22
# Part 1

deck1, deck2 = File.read(ARGV[0] || 'input.txt').split("\n\n").map { |n|
  n.lines[1..-1].map(&:to_i)
}

until (deck1.empty? || deck2.empty?)
  card1 = deck1.shift
  card2 = deck2.shift

  if card1 > card2
    deck1.push card1
    deck1.push card2
  else
    deck2.push card2
    deck2.push card1
  end
end

winner = deck1.empty? ? deck2 : deck1

p winner.each_with_index.sum { |card, idx| card * (winner.size - idx) }
