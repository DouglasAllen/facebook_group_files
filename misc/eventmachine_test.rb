require 'rubygems'
require 'eventmachine'
require 'em-http'
require 'pp'

$stdout.sync = true

class KeyboardHandler < EM::Connection
  include EM::Protocols::LineText2

  def post_init
    print '> '
  end

  def receive_line(line)
    line.chomp!
    line.gsub!(/^\s+/, '')

    case line
    when /^get (.*)$/ then
      site = Regexp.last_match(1).chomp
      sites = site.split(',')

      multi = EM::MultiRequest.new
      sites.each do |s|
        multi.add(EM::HttpRequest.new(s).get)
      end
      multi.callback do
        puts ''
        multi.responses[:succeeded].each do |h|
          pp h.response_header.status
          pp h.response_header
        end
        multi.responses[:failed].each do |h|
          puts "#{h.inspect} failed"
        end
        print '> '
      end
      print '> '

    when /^exit$/ then
      EM.stop

    when /^help$/ then
      puts 'get URL[,URL]*   - gets a URL'
      puts 'exit      - exits the app'
      puts 'help      - this help'
      print '> '
    end
  end
end

EM.run do
  EM.open_keyboard(KeyboardHandler)
end
puts 'Finished'
