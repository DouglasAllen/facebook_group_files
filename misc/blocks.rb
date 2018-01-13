# Adapted from Learning Ruby by Michael Fitzgerald, O'Reilly

def gimme
  if block_given?
    yield
  else
    print 'Oops, no block.'
  end
  puts "\n You're welcome."
end

gimme { print 'Thank you.' }

gimme do
  local_x = 'Thank you again.'
  print local_x
end

gimme # no block
