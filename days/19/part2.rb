#!/usr/bin/env ruby

# AoC 2020
# Day 
# Part 2

input = File.read(ARGV[0] || 'input.txt')

raw_rules, messages = input.split("\n\n").map { _1.lines.map(&:chomp) }

raw_rules = raw_rules.map { |rr|
  if rr.start_with? '8:' 
    '8: 42 | 42 8'
  elsif rr.start_with? '11:'
    '11: 42 31 | 42 11 31'
  else
    rr
  end
}

rules = raw_rules.map { |r|
  num, rest = r.split(': ')
  n = num.to_i

  r = nil
  if rest.start_with? ?"
    r = eval rest
  else
    r = rest.split(' | ').map { _1.split.map(&:to_i) }
  end

  [n, r]
}.to_h


def to_regex rules, rule = rules[0], depth = 0

  return nil if depth >= 20

  if rule.class == String
    return rule
  else
    a = rule.map {
      _1.map { |r| to_regex rules, rules[r], (depth + 1) }.join
    }.join('|')
    "(#{a})".gsub('(|)', '')
  end
end

re = Regexp.new "^#{to_regex(rules)}$"
p re

p messages.map { re.match? _1 }.select { _1 }.size

