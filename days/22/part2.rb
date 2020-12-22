#!/usr/bin/env ruby

require 'set'

# AoC 2020
# Day 22
# Part 2

deck1, deck2 = File.read(ARGV[0] || 'input.txt').split("\n\n").map { |n|
  n.lines[1..-1].map(&:to_i)
}

def play_game(deck1, deck2)
  rounds = Set.new
  until (deck1.empty? || deck2.empty?)
    if rounds.include? [deck1, deck2]
      return [1, deck1]
    end

    rounds.add([deck1.dup, deck2.dup])

    card1 = deck1.shift
    card2 = deck2.shift

    if (deck1.size >= card1 && deck2.size >= card2)
      winner, _ = play_game(deck1[0..card1-1].dup, deck2[0..card2-1].dup)
      if winner == 1
        deck1.push card1
        deck1.push card2
      else
        deck2.push card2
        deck2.push card1
      end
    else
      if card1 > card2
        deck1.push card1
        deck1.push card2
      else
        deck2.push card2
        deck2.push card1
      end
    end
  end

  winner = deck1.empty? ? 2 : 1
  winning_deck = deck1.empty? ? deck2 : deck1

  return [winner, winning_deck]
end

_, winning_deck = play_game(deck1, deck2)

p winning_deck.each_with_index.sum { |card, idx| card * (winning_deck.size - idx) }
