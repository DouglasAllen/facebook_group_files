$global_x = 'I am a global var named x'
p $global_x

$global_y = 'I am another global var named y!'
p $global_y

local_x = 'I am a local var named x in <main>'
p local_x

def foo
  really_local_x = 'I am a local in foo'
  puts really_local_x
  $global_x << $global_y
  p $global_x
  p local_x
end

$global_x << ' --- '
foo
p $global_x
