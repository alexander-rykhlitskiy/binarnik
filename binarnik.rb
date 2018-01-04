#!/usr/bin/env ruby
require 'json'

file_name = ARGV[0]
line_number = ARGV[1].to_i

lines = JSON.pretty_generate(JSON.parse(File.read(file_name))).split("\n")

path = lines[0...line_number].each_with_object([]).with_index do |(line, obj), index|
  case line
  when /[\[\{]/, ->(_) { index == line_number - 1 }
    obj << line
  when /[\]\}]/
    obj.pop
  end
end

result = path.join.gsub(/\s/, '').gsub(/\,\Z/, '')
puts result
puts 'Result was copied to clipboard'
`echo '#{result}' | pbcopy`
