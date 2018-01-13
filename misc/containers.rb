require 'set'

my_array = [1, 2, 3, 'hello', false, true, nil]
my_hash = {'John' => 26, 'Jane' => 21, 'Jack' => 30}
my_set = my_array.to_set
puts my_set.inspect
my_hash['nested array'] = my_array
puts my_hash
my_array[1] = ['a', 'b', 'c']
p my_array
