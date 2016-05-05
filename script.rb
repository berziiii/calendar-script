#!/usr/bin/env ruby

require 'date'

fail 'Usage: script.rb <input_file> <output_file> <interval_weeks>' if ARGV.empty?

input_file = ARGV[0]
output_file = File.open(ARGV[1], "w")
# Number of weeks multiplied by 7 days a week to increase by number of days
INTERVAL_DAYS = ((ARGV[2].to_i) * 7)

def parse_event(line, delimiter)
  d = line.split(/[\:\=](\d{8})/)
  d[1] = Date.parse(d[1])
  return line if d[1].year < 2016
  d[1] = (d[1] + INTERVAL_DAYS).to_s.gsub('-', '')
  if d[2]
    d = d[0] + "#{delimiter}" + d[1] + d[2]
  else
    d = d[0] + "#{delimiter}" + d[1]
  end
end

# Opens input file to create new file from
File.open(input_file) do |file|

# Loops through each line of file and labels it line
  file.each do |line|

    if line.include?("RRULE:") && line.include?("UNTIL=")

      line = parse_event(line, "=")

    elsif line.include?("DTSTART:")

      line = parse_event(line, ":")

    elsif line.include?("DTEND:")

      line = parse_event(line, ":")

    elsif line.include?("DTSTART;VALUE=")

      line = parse_event(line, ":")

    elsif line.include?("DTEND;VALUE=")

      line = parse_event(line, ":")

    elsif line.include?("DTSTART;TZID=")

      line = parse_event(line, ":")

    elsif line.include?("DTEND;TZID=")

      line = parse_event(line, ":")

    end
# Takes line value, either copied or altered, and writes to output file
    output_file.write(line)
# Ends loop once it loops through whole input file
  end
# Closes output file which new calendar was written to
  output_file.close
# Closes input file to secure old data
end
