#!/usr/bin/env ruby

require 'set'

# AoC 2020
# Day 21
# Part 1

input = File.readlines(ARGV[0] || 'input.txt').map(&:chomp).map { |l|
  words, allergens = l.split(' (contains ')

  w = words.split
  a = allergens[0..-2].split(', ')

  [a, w]
}

allergen_names = Set.new input.map(&:first).flatten.uniq

allergen_map = allergen_names.map do |a|
  [
    a,
    input.select { |list, _| list.include? a }.map(&:last).reduce(&:&)
  ]
end.to_h


possible_allergens = allergen_map.map(&:last).flatten.uniq

all_ingredients = input.map(&:last).flatten

no_allergens = all_ingredients.reject { possible_allergens.include? _1 }
p no_allergens.size
