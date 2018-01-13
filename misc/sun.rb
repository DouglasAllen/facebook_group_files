require 'date'
include Math
D2R = PI / 180.0
R2D = 180.0 / PI

# Geometric Mean Longitude
def gml_sun(jc)
  (280.46646 + jc * (36_000.76983 + jc * 0.0003032)) % 360.0
end

# Geometric Mean Anomaly
def gma_sun(jc)
  357.52911 + jc * (35_999.05029 - 0.0001537 * jc) % 360.0
end

# Earth Eliptical Orbit
def eeo(jc)
  0.016708634 - jc * (0.000042037 + 0.0000001267 * jc)
end

# Equation of Center
def sun_eoc(jc)
  eoc_1(jc) +
    eoc_2(jc) +
    eoc_3(jc)
end

def eoc_1(jc)
  sin((gma_sun(jc) * D2R)) * (1.914602 - jc * (0.004817 + 0.000014 * jc))
end

def eoc_2(jc)
  sin(D2R * (2 * gma_sun(jc))) * (0.019993 - 0.000101 * jc)
end

def eoc_3(jc)
  sin(D2R * (3 * gma_sun(jc))) * 0.000289
end

# True Longitude
def sun_tl(jc)
  sun_eoc(jc) + gml_sun(jc)
end

# Apparent Longitude
def sun_al(jc)
  sun_tl(jc) - 0.00569 - 0.00478 * sin(D2R * (125.04 - 1934.136 * jc))
end

# Mean Obliquity Earth
def mobe(jc)
  23 + (26 + ((21.448 - jc * (46.815 + jc * (0.00059 -
  jc * 0.001813)))) / 60.0) / 60.0
end

# Obliquity Correction
def obc(jc)
  mobe(jc) + 0.00256 * cos(D2R * (125.04 - 1934.136 * jc))
end

# Declination
def sun_dec(jc)
  R2D * asin(sin(D2R * obc(jc)) * sin(D2R * sun_al(jc)))
end

# Tangent 1/2 Obliquity Squared
def foo_y(jc)
  tan(D2R * (obc(jc) / 2.0)) * tan(D2R * (obc(jc) / 2.0))
end

# Equation of Time
def eot(jc)
  4.0 * R2D * (
    eot_t1(jc) -
    eot_t2(jc) +
    eot_t3(jc) -
    eot_t4(jc) -
    eot_t5(jc)
  )
end

def eot_t1(jc)
  foo_y(jc) * sin(2.0 * D2R * gml_sun(jc))
end

def eot_t2(jc)
  2.0 * eeo(jc) * sin(D2R * gma_sun(jc))
end

def eot_t3(jc)
  4.0 * eeo(jc) * foo_y(jc) * sin(D2R * gma_sun(jc)) * cos(2.0 * D2R * gml_sun(jc))
end

def eot_t4(jc)
  0.5 * foo_y(jc) * foo_y(jc) * sin(4.0 * D2R * gml_sun(jc))
end

def eot_t5(jc)
  1.25 * eeo(jc) * eeo(jc) * sin(2.0 * D2R * gma_sun(jc))
end

# Horizon Angle = angle degrees for half a day
def sun_ha(jc, lat)
  R2D * acos(trig_1(jc, lat) - trig_2(jc, lat))
end

def zenith
  D2R * 90.833
end

def trig_1(jc,lat)
  cos(zenith) / (cos(D2R * lat) * cos(D2R * sun_dec(jc)))
end

def trig_2(jc, lat)
  tan(D2R * lat) * tan(D2R * sun_dec(jc))
end


latitude = 41.9475
longitude = -88.743
tz_offset = -5

date = Date.today
jd = date.jd
jc = (jd - 2_451_545) / 36_525.0

solar_noon = (720.0 - 4.0 * longitude - eot(jc) + tz_offset * 60.0) / 1440.0
sunrise_time = solar_noon - sun_ha(jc, latitude) * 4.0 / 1440.0
sunset_time = solar_noon + sun_ha(jc, latitude) * 4.0 / 1440.0

sunlight_duration = (8.0 * sun_ha(jc, latitude)) / 60.0
set_jd = jd + sunset_time
noon_jd = jd + solar_noon
rise_jd = jd + sunrise_time

puts "Sunrise #{DateTime.jd(rise_jd - tz_offset / 24.0).to_time}"
puts "Midday  #{DateTime.jd(noon_jd - tz_offset / 24.0).to_time}"
puts "Sunset  #{DateTime.jd(set_jd - tz_offset / 24.0).to_time}"
puts "Daylight hours #{sunlight_duration}"
