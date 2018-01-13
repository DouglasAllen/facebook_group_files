
require 'eot'
require 'calc_sun'
require 'sphere'

cs = CalcSun.new
et = Eot.new
sun = Sphere::Sun.new
dt = sun.time(DateTime.now)
p dt

p cs.jd(DateTime.now)
p et.jd
# p sun.jd

p cs.ajd(DateTime.now)
p et.ajd
# p sun.ajd

p cs.mean_anomaly(cs.jd(DateTime.now))
p et.ma_sun
p sun.sma
puts
p cs.methods.sort - Object.methods
puts
# p et.methods.sort - Object.methods
puts
p sun.methods.sort - Object.methods
puts
