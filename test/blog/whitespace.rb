# Whether a given string includes any whitespace.
def includes_whitespace?(string)
  not string.match(/\s/).nil?
end
