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

@old_calendar.each do |line|

  if line.include?("DTSTART:")

    # splits calendar value at : to get date & time of event
    @d = line.split(":", 2)

    # splits date & time value at T to get separate date value from time value
    @d = @d[1].split("T", 2)

    # saved time value to @t
    @t = @d[1]

    # saved date value to @d
    @d = @d[0]

    # parse date value to be date format
    @d = Date.parse(@d)

    # check to see if date is before the date of cohort, if so, do not change (Daylight savings, etc.)
    if @d < @old_calendar_start_date
      @d = @d.to_s.gsub('-', '')

      @d = 'DTSTART:' + @d + 'T' + @t

      line = @d

    #if date of event is equal to or after old cohort launch date, apply changes
    else

      # add @n (days between cohorts) to date value (@d), convert to string and remove '-'
      @d = (@d+@n).to_s.gsub('-', '')

      # stringify value to match database format
      @d = 'DTSTART:' + @d + 'T' + @t

      # change value of data input to new date value
      line = @d
    end


  elsif line.include?("DTSTART;TZID=America/New_York:")

    # splits calendar value at : to get date & time of event
    @d = line.split(":", 2)

    # splits date & time value at T to get separate date value from time value
    @d = @d[1].split("T", 2)

    # saved time value to @t
    @t = @d[1]

    # saved date value to @d
    @d = @d[0]

    # parse date value to be date format
    @d = Date.parse(@d)

    # add @n (days between cohorts) to date value (@d), convert to string and remove '-'
    @d = (@d+@n).to_s.gsub('-', '')

    # stringify value to match database format
    @d = 'DTSTART;TZID=America/New_York:' + @d + 'T' + @t

    # change value of data input to new date value
    line = @d

  ### DTEND time value change ###

  elsif line.include?("DTEND:")

    # splits calendar value at : to get date & time of event
    @d = line.split(":", 2)

    # splits date & time value at T to get separate date value from time value
    @d = @d[1].split("T", 2)

    # saved time value to @t
    @t = @d[1]

    # saved date value to @d
    @d = @d[0]

    # parse date value to be date format
    @d = Date.parse(@d)

    # check to see if date is before the date of cohort, if so, do not change (Daylight savings, etc.)
    if @d < @old_calendar_start_date

      @d = @d.to_s.gsub('-', '')

      @d = 'DTEND:' + @d + 'T' + @t

      line = @d

    #if date of event is equal to or after old cohort launch date, apply changes
    else

      # add @n (days between cohorts) to date value (@d), convert to string and remove '-'
      @d = (@d+@n).to_s.gsub('-', '')

      # stringify value to match database format
      @d = 'DTEND:' + @d + 'T' + @t

      # change value of data input to new date value
      line = @d

    end

  elsif line.include?("DTEND;TZID=America/New_York")

    # splits calendar value at : to get date & time of event
    @d = line.split(":", 2)

    # splits date & time value at T to get separate date value from time value
    @d = @d[1].split("T", 2)

    # saved time value to @t
    @t = @d[1]

    # saved date value to @d
    @d = @d[0]

    # parse date value to be date format
    @d = Date.parse(@d)

    # add @n (days between cohorts) to date value (@d), convert to string and remove '-'
    @d = (@d+@n).to_s.gsub('-', '')

    # stringify value to match database format
    @d = 'DTEND;TZID=America/New_York:' + @d + 'T' + @t

    # change value of data input to new date value
    line = @d

  ### DTSTART;VALUE=DATE value change ###

  elsif line.include?("DTSTART;VALUE=DATE:")

    # splits calendar value at : to get date & time of event
    @d = line.split(":", 2)

    # save date value to variable @d
    @d = @d[1]

    # parse date value to be date format
    @d = Date.parse(@d)

    # add @n (days between cohorts) to date value (@d), convert to string and remove '-'
    @d = (@d+@n).to_s.gsub('-', '')

    # stringify value to match database format
    @d = 'DTSTART;VALUE=DATE:' + @d

    # change value of data input to new date value
    line = @d

  ### DTEND;VALUE=DATE value change ###

  elsif line.include?("DTEND;VALUE=DATE:")

    # splits calendar value at : to get date & time of event
    @d = line.split(":", 2)

    # save date value to variable @d
    @d = @d[1]

    # parse date value to be date format
    @d = Date.parse(@d)

    # add @n (days between cohorts) to date value (@d), convert to string and remove '-'
    @d = (@d+@n).to_s.gsub('-', '')

    # stringify value to match database format
    @d = 'DTEND;VALUE=DATE:' + @d

    # change value of data input to new date value
    line = @d

  ### RRULE time/frequency change ###

  elsif line.include?("RRULE:") && line.include?("UNTIL=")

    # splits calendar value at : to get date & time of event
    @d = line.split("UNTIL=", 2)

    #saves 'RRULE & FREQ as variable @header'
    @header = @d[0]

    #splits date/time from BYDAY value
    @d = @d[1].split(";", 2)

    #saves BYDAY value as variable @days
    @days = @d[1]

    #saves date and time value as @d
    @d = @d[0].split("T", 2)

    #saves time value as T
    if !@d[1].nil?
      @t = 'T' + @d[1]
    else
      @t = ''
    end

    # saved date value to @d
    @d = @d[0]

    # parse date value to be date format
    @d = Date.parse(@d)

    # add @n (days between cohorts) to date value (@d), convert to string and remove '-'
    @d = (@d+@n).to_s.gsub('-', '')

    # # stringify value to match database format
    @d = @header + 'UNTIL=' + @d + @t + ';' + @days

    line = @d

  end

  @new_calendar.write(line)

end

@new_calendar.close
