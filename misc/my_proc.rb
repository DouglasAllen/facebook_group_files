
x = 0.17007312262750117
polynomial = ->(a, b, c, d, e) { (e * x + (d * x + (c * x + b))) * x + a }

puts polynomial.call(357.52911,
                     35_999.05029,
                     -0.0001537,
                     3.778e-08,
                     -3.191667e-09) % 360.0

jdn = x * 36_525
puts jdn
jdn += 2_451_545.0
puts jdn
require 'date'
puts DateTime.jd(jdn + 0.5)
