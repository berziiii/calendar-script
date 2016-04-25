require 'date'

old_file = 'WDI_BOS_011.ics'

new_file = 'WDI_BOS_012.ics'

# #n = number of days between cohorts (7 days in a week and 4 weeks)
NUM_DAYS = 56

old_calendar = File.open(old_file)

new_calendar = File.open(new_file, "w")

def split_two(line)

  d = line.split(/\:([0-9]{8})/, 2)
  header = d[0]
  d = Date.parse(d[1])
  d = (d + NUM_DAYS).to_s.gsub('-', '')
  d = header + ':' + d
  line = d

end

def split_three (line)

  d = line.split(/\:([0-9]{8})/, 3)
  header = d[0]
  tail = d[2]
  d = Date.parse(d[1])
  d = (d + NUM_DAYS).to_s.gsub('-', '')
  d = header + ':' + d + tail
  line = d

end


old_calendar.map do |line|

  if line.include?("RRULE:") && line.include?("UNTIL=")

    d = line.split(/\=([0-9]{8})/, 3)
    header = d[0]
    tail = d[2]
    d = Date.parse(d[1])
    d = (d + NUM_DAYS).to_s.gsub('-', '')
    d = header + '=' + d + tail
    line = d

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

  new_calendar.write(line)

end

new_calendar.close
