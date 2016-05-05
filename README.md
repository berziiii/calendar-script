# calendar-script

## Purpose
The purpose of this calendar script is to take an exisiting Google calendar or iCalendar and create a new calendar from it. 

## Problem
There was an exisiting Google calendar that had over 200 events associated with it. To help streamline processes of duplicating the calendar, without having to copy each individual event to a new date. 
A second problem was to manually move each copied calendar date to it's new home.

## Solution
Created a script which takes an exisiting .ics file and copies it to a new .ics calendar. You can either copy the entire calendar to have it's events
appear on the same day, or add n number of days to the calendar. This will move the new events dates up by n days while keeping all information (time, summary, description, etc.)
the same. 

## Usage
Once you have the script.rb file cloned, choose which input calendar you'd like to copy and create a file for the new calendar. 
To run the script execute 

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
