
# hello_world.rb
class HelloWorld
  def self.hello
    'Hello, World!'
  end
end

system 'ruby hello_world_test.rb' if $PROGRAM_NAME == __FILE__
