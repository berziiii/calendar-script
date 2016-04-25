require 'date'

@old_file = 'WDI_BOS_011.ics'

@new_file = 'WDI_BOS_012.ics'

#start date of old cohort
@old_calendar_start_date = Date.new(2016,03,21)

# #n = number of days between cohorts (7 days in a week and 4 weeks)
@n = 56

@old_calendar = File.open(@old_file)

@new_calendar = File.open(@new_file, "w")

### DTSTART time value change ###

def split_two
  @d = line.split(/\:([0-9]{8})/, 2)
  @header = @d[0]
  @d = Date.parse(@d[1])

  # check to see if date is before the date of cohort, if so, do not change (Daylight savings, etc.)
  if @d < @old_calendar_start_date

    @d = @d.to_s.gsub('-', '')

    line = @header + ':' + @d

  else

    @d = (@d+@n).to_s.gsub('-', '')

    line = @header + ':' + @d

  end
end

def split_three
  @d = line.split(/\:([0-9]{8})/, 3)
  @header = @d[0]
  @tail = @d[2]
  @d = Date.parse(@d[1])

  # check to see if date is before the date of cohort, if so, do not change (Daylight savings, etc.)
  if @d < @old_calendar_start_date

    @d = @d.to_s.gsub('-', '')

    line = @header + ':' + @d + @tail

  else

    @d = (@d+@n).to_s.gsub('-', '')

    line = @header + ':' + @d + @tail

  end
end


@old_calendar.map do |line|

  if line.include?("DTSTART:")

    line.method(:split_three)

  elsif line.include?("DTEND:")

    line.method(:split_three)

  elsif line.include?("DTSTART;VALUE=")

    line.method(:split_two)

  elsif line.include?("DTEND;VALUE=")

    line.method(:split_two)

  elsif line.include?("DTSTART;TZID=")

    line.method(:split_three)

  elsif line.include?("RRULE:") && line.include?("UNTIL=")

    @d = line.split(/\=([0-9]{8})/, 3)
    @header = @d[0]
    @tail = @d[2]
    @d = Date.parse(@d[1])

    # check to see if date is before the date of cohort, if so, do not change (Daylight savings, etc.)
    if @d < @old_calendar_start_date

      @d = @d.to_s.gsub('-', '')

      line = @header + '=' + @d + @tail

    else

      @d = (@d+@n).to_s.gsub('-', '')

      line = @header + '=' + @d + @tail

    end

  end

  @new_calendar.write(line)

end

@new_calendar.close
