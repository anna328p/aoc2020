#!/usr/bin/env ruby

# AoC 2020
# Day 16
# Part 2

raw_types, raw_ticket, raw_nearby = File.read(ARGV[0] || 'input.txt').split("\n\n")

types = raw_types
  .lines
  .map(&:chomp)
  .map { _1.split ?: }
  .map { |k, v|
    [k, v
      .split(" or ")
      .map {
        Range.new(*(
          _1.split(?-)
            .map(&:to_i)
        ))
        a, b = _1.split(?-).map(&:to_i); a..b
      }
    ]
  }.to_h

ticket = raw_ticket.lines.last.chomp.split(?,).map(&:to_i)

nearby = raw_nearby.lines[1..-1].map { |l| l.chomp.split(?,).map(&:to_i) }

# ---

valid = nearby.filter { |r| r.all? { |v| types.any? { |_, r| r.any? { _1.include? v }} } }

# ---

good = []

cols = valid.transpose

field_map = Array.new(cols.size) { Array.new }

cols.each_with_index do |col, idx|
  types.each do |name, ranges|
    a, b = ranges
    if col.all? { a.include?(_1) || b.include?(_1) }
      field_map[idx] << name
    end
  end
end


remaining = types.dup

loop do
  field_map.map.with_index { |names, idx|
    if names&.size == 1
      f = names.first
      good[idx] = f
      remaining.delete(f)
      field_map.each { |a| a.delete_if { _1 == f } }
    end
  }

  break if remaining.empty?
end


# ---

t = good.map.with_index { |val, idx| [val, ticket[idx]]}.filter { |name, field| name.start_with? 'departure' }
p t.map(&:last).inject(:*)
