
require 'date'
include Math
##############
latitude = 41.95
longitude = -88.75
timezone = -6
##############

##############
# Go to http://www.cerebralmeltdown.com for the original location of this program
# Sources used for this program
# Meeus, Jean. Astronomical Algorithms. 2nd ed. Willmann-Bell, Inc, 2005.
##################
#
class Numeric
  include Math
  # Degrees to radians.
  def dtr
    self * PI / 180.0
  end

  # Radians to degrees.
  def rtd
    self * 180.0 / PI
  end
end
#
class Float
  alias round_orig round
  def round(n = 0)
    (self * (10.0**n)).round_orig * (10.0**-n)
  end
end

# Longitude in Hours
longitude = (longitude * -1) / 15

######################
# Begin Julian Day Calculation (Meeus Pages 59-61) vvvv
t = Time.now
y = t.gmtime.year
m = t.gmtime.month
d = t.gmtime.day +
    t.gmtime.hour / 24.to_f +
    t.gmtime.min / 1440.to_f +
    t.gmtime.sec / 86_400.to_f
if m > 2
  y = y
  m = m
else
  y -= 1
  m += 12
end

a = (y / 100).to_int
b = 2 - a + (a / 4).to_int
jd = (365.25 * (y + 4716)).to_int + (30.6001 * (m + 1)).to_int + d + b + -1524.5
# End Julian Day Calculation^^^^
######################

jd = DateTime.now.ajd.to_f

################
# (Meeus Pages 163-164) vvv
# Time in Julian Centuries
t = ((jd - 2_451_545.0) / 36_525.0)

# Mean equinox of the date
l = 280.46645 + 36_000.76983 * t + 0.0003032 * t * t

# Mean Anomaly of the Sun
m = 35_999.05030 * t -
    0.0001559 * t * t -
    0.00000048 * t * t * t +
    357.52911

# Eccentricity of the Earth's Orbit not used here yet.
e = 0.016708617 -
    0.000042037 * t -
    0.0000001236 * t**2

# Sun's Equation of the center
c = (1.914600 - 0.004817 * t -
     0.000014 * t**2) * sin(m.dtr) +
    (0.019993 - 0.000101 * t) * sin(2 * m.dtr) +
    0.000290 * sin(3 * m.dtr)

# Sun's True Longitude
o = l + c

# Brings 'o' within + or - 360 degrees.
# (Taking an inverse function of very large numbers can
# sometimes lead to slight errors in output)
o = o.divmod(360)[1]
################

###############
# (Meeus Page 164)
# Sun's Apparant Longitude (The Output of Lambda)
omega = 125.04 - 1934.136 * t
lambda = o - 0.00569 - 0.00478 * sin(omega.dtr)

# Brings 'lambda' within + or - 360 degrees.
# (Taking an inverse function of very large numbers can
# sometimes lead to slight errors in output)
lambda = lambda.divmod(360)[1]
###############

# Obliquity of the Ecliptic (Meeus page 147)
# (numbers switched from degree minute second in book to decimal degree)
epsilon = (23.4392966666667 -
            0.012777777777777778 * t -
            0.00059 / 60.0 * t**2 +
            0.00059 / 60.0 * t**3
          ) +
          0.00256 * cos(omega.dtr)

# Sun's Declination (Meeus page 165)
delta = asin(sin(epsilon.dtr) * sin(lambda.dtr)).rtd

# Sun's Right Acension (Meeus page 165) (divided by 15 to convert to hours)
alpha = atan2(((cos(epsilon.dtr) * sin(lambda.dtr))),
              cos(lambda.dtr)).rtd / 15
alpha += 24 if alpha < 0

# Sidereal Time (Meeus Page 88)
theta = (280.46061837 +
         360.98564736629 * (jd - 2_451_545.0) +
           0.000387933 * t * t -
           (t * t * t) / 38_710_000)

# Brings 'theta' within + or - 360 degrees.
# (Taking an inverse function of very large numbers can sometimes lead to slight errors in output)
theta = theta.divmod(360)[1] / 15.to_f

# The Local Hour Angle (Meeus Page 92) (multiplied by 15 to convert to degrees)
h = (theta - longitude - alpha) * 15
# Brings 'h' within + or - 360 degrees.
# (Taking an inverse function of very large numbers can sometimes lead to slight errors in output)
h = h.divmod(360)[1]

############
# Local Horizontal Coordinates (Meeus Page 93)
# Altitude
altitude = asin(sin(latitude.dtr) *
                    sin(delta.dtr) +
                    cos(latitude.dtr) *
                    cos(delta.dtr) *
                    cos(h.dtr)).rtd.round(12)

# Azimuth
azimuth = atan2(sin(h.dtr),
                (cos(h.dtr) * sin(latitude.dtr) -
                 tan(delta.dtr) * cos(latitude.dtr)
                )).rtd.round(12)
############

puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
puts "  Time now : #{Time.now}"
puts
puts "  Julian Day: #{jd}"
puts "  altitude = #{altitude}"
puts "  azimuth = #{180 + azimuth}"
puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
