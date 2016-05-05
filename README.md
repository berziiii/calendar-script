# calendar-script

## Purpose
The purpose of this calendar script is to take an exisiting Google calendar or
iCalendar and create a new calendar from it.

## Problem
There was an exisiting Google calendar that had over 200 events associated with
it. In order to duplicate the old .ics calendar, you had to copy each individual
 event to a new date. A second problem was the trivial, and time consuming,
 process of manually moving each copied calendar event to it's new date.

## Solution
Created a Ruby script which takes an exisiting .ics file and copies it to a new
.ics calendar file. You can either copy the entire calendar to have it's events
appear on the same day or add *n* number of days to the calendar. This will move
the new events dates up by *n* days while keeping all information
(time, summary, description, etc.) the same as the old .ics file.

## Usage
Once you have the script.rb file cloned, choose which input calendar file you'd
like to copy and create a file for the new .ics calendar file.

To run the script, execute this command in terminal:

```ruby
ruby script.rb <input_file> <output_file> <interval_weeks>
```

This script takes the old .ics calendar file, new .ics calendar file and the
number of weeks you'd like the event dates to be adjusted.

Below you'll find the *parse_event* method which loops through the file and
parses each event:

```ruby

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

```
The INTERVAL_DAYS variable, takes the <interval_weeks> argument value and
multiplies it by 7 (days in a week) to get the total days to increase the new
calendar events by.

The parse_event method iterates over each line of the input .ics file and
checks for these cases:

```ruby

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
```

To check to confirm that the changes have taken place between your old and new
calendar files, you can run this command in terminal:

```ruby

diff <input_file> <output_file> |less

```

You will see the differences between the two calendar files. It should have the
same number of lines, the only thing that should have changed is the date of the
events. The format of the date is yyyymmdd. You should see the difference
between the dates be the INTERVAL_DAYS value. Another way to confirm that the
file size is the same run in terminal:

```ruby

ls -l

```

Locate your old and new .ics files and you should see the size of the files be
identical.
