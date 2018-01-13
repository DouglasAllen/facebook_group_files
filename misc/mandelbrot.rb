
require 'imageruby'
require 'awesome_print'
require 'pry'

include ImageRuby

X_START = -2.0
X_END = 0.5
Y_START = -1.0
Y_END = 1.0

WIDTH = 30_000
HEIGHT = 20_000

image = Image.new(WIDTH, HEIGHT)

STEP_X = (X_END - X_START) / WIDTH
STEP_Y = (Y_END - Y_START) / HEIGHT

ITERATIONS = 300

def mandelbrot(a)
  Array.new(ITERATIONS, a).inject(a) { |z, c| z * z + c }
end

MIN_X =
  x_pixel = 0
y_pixel = 0

x = X_START
y = Y_START

t = Time.now
print 'processing ... '

while y < Y_END
  x_pixel = 0
  x = X_START
  while x < X_END
    mandelbrot(Complex(x, y)).abs < 2 ? image.set_pixel(x_pixel, y_pixel, Color.from_rgb(255, 255, 255)) : nil
    x_pixel += 1
    x += STEP_X
  end
  y_pixel += 1
  y += STEP_Y
end

puts "Done #{Time.now - t}"

image.save 'blub.bmp', :bmp

exit

# 0,0      800,0
#
# 0,400    800,400

#-2:1     1:1
#
#-2:-1    1:-1

def morph(x, y); end

def mandelbort(c)
  50.times do
    c += c
    break if c.abs > 2
  end
  c.abs < 2
end

def mandelbrot1(a)
  Array.new(50, a).inject(a) { |z, c| z * z + c }
end

set = image.map_pixel do |x, y|
  if mandelbort(Complex(x / 200.0, y / 200.0))
    Color.from_rgb(255, 255, 255)
  else
    Color.from_rgb 0, 0, 0
  end
end

set.save 'blub.bmp', :bmp
