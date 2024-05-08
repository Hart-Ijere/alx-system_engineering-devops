#!/usr/bin/env ruby
inputString = ARGV[0]
pattern = /hbt+tn/
matchedText = inputString.match(pattern)
if matchedText
  puts"Matched found: #{matchedText[0]}"
else
  put"No match found"
end
