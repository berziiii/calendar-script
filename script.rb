#!/usr/bin/env ruby

# require 'date'
#
fail 'Usage: script.rb <input_file> <output_file> <interval_days>' if ARGV.empty?

input_file = ARGV[0]
output_file = ARGV[1]
interval_days = ARGV[2]

# NUM_DAYS = 56
#
# old_calendar = File.open(old_file)
#
# new_calendar = File.open(new_file, "w")
#

def parse_event(line, delimiter)
  d = line.split(/[\:\=](\d{8})/)
  d[1] = Date.parse(d[1])
  d[1] = (d[1] + 56).to_s.gsub('-', '')
  if d[2]
    d = d[0] + "#{delimiter}" + d[1] + d[2]
  else
    d = d[0] + "#{delimiter}" + d[1]
  end
end


File.open(input_file) do |line|

  if line.include?("RRULE:") && line.include?("UNTIL=")

    line = parse_event(line, "=")

  elsif line.include?("DTSTART:")

    line = split_three(line)

  elsif line.include?("DTEND:")

    line = split_three(line)

  elsif line.include?("DTSTART;VALUE=")

    line = split_two(line)

  elsif line.include?("DTEND;VALUE=")

    line = split_two(line)

  elsif line.include?("DTSTART;TZID=")

    line = split_three(line)

  end

    output_file.write(line)

end

  output_file.close


#
# old_calendar.map do |line|
#
#   if line.include?("RRULE:") && line.include?("UNTIL=")
#
#     d = line.split(/\=([0-9]{8})/, 3)
#     header = d[0]
#     tail = d[2]
#     d = Date.parse(d[1])
#     d = (d + NUM_DAYS).to_s.gsub('-', '')
#     d = header + '=' + d + tail
#     line = d
#
#   elsif line.include?("DTSTART:")
#
#     line = split_three(line)
#
#   elsif line.include?("DTEND:")
#
#     line = split_three(line)
#
#   elsif line.include?("DTSTART;VALUE=")
#
#     line = split_two(line)
#
#   elsif line.include?("DTEND;VALUE=")
#
#     line = split_two(line)
#
#   elsif line.include?("DTSTART;TZID=")
#
#     line = split_three(line)
#
#   end
#
#   new_calendar.write(line)
#
# end
#
# new_calendar.close
#old_calendar.close
