#!/usr/bin/env ruby
inputString = ARGV[0]
pattern = /School/
matchedText = inputString.match(pattern)
if matchedText
  puts"Match found: #{matchedText[0]}"
else
  puts"Cant find match."
end

