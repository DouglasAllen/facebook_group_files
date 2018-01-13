#!/usr/local/bin/ruby
require 'date'
require 'cgi'

# doc
class Clock
  attr_accessor :date, :year, :month, :time, :day, :hour, :min, :sec

  def initialize(date)
    @date = date.to_datetime.to_time.utc
    @time = @date
    date_parts(date)
    time_parts(date)
  end

  def time_in_day
    @hour.to_f / 24 + @min.to_f / 1140 + @sec.to_f / 86_400
  end

  def time_in_hour
    @hour.to_f + @min.to_f / 60 + @sec.to_f / 3600
  end

  def time_in_sec
    @hour * 3600 + @min * 60 + @sec
  end

  def date_parts(data)
    @year = data.year
    @month = data.month
    @day = data.day
  end

  def time_parts(data)
    @hour = data.hour
    @min = data.min
    @sec = data.sec
  end

  def the_variables(date)
    @date = date.to_datetime.to_time.utc
    @time = @date
    date_parts(date)
    time_parts(date)
  end
=begin
  def jd
    if @month <= 2
      y = (@year - 1).to_i
      m = (@month + 12).to_i
    else
      y = @year
      m = @month
    end

    julian_day = (
      365.25 * (y + 4716)).floor + (30.6001 * (m + 1)).floor + @day - 1524.5

    if julian_day < 2_299_160.5
      transition_offset = 0
    else
      tmp = (@year / 100).floor
      transition_offset = 2 - tmp + (tmp / 4).floor
    end

    julian_day + transition_offset
  end
=end
end

=begin
# doc
class SplitData
  def initialize(data)
    @data_array = []
    @data = data
  end

  def split
    @data_array << @data[1..1].to_i # version
    @data_array << @data[2..2].to_i # body
    @data_array << @data[3..3].to_i # index
    @data_array << @data[4..4].to_i # alpha
    @data_array << @data[79..96].to_f # A
    @data_array << @data[97..110].to_f # B
    @data_array << @data[111..130].to_f # C
    @data_array
  end
end
# doc
class VSOP87
  def initialize(data_set, jd)
    @data_set = data_set
    @jd = jd
  end

  def load
    data_array = []
    open(@data_set) do |file|
      while line = file.gets
        if line[1..1] != 'V'
          r = SplitData.new(line)
          data_array << r.split
        end
      end
    end
    data_array
  end

  def calc
    data_array = load
    t = ((@jd - 2_451_545.0) / 365_250).to_f
    v = []
    data_array.each do |data|
      i = data[2] - 1
      v[i] = 0 if v[i].nil?
      v[i] = v[i].to_f + (
        t**data[3]) * data[4].to_f * Math.cos(data[5].to_f + data[6].to_f * t)
    end
    v
  end
end

#

input = CGI.new
data_set = input['f']
jd = input['d']
print "Content-type:text/plain\n\n"
if data_set
  unless jd
    date = Time.now
    time = Clock.new(date)
    jd = time.jd
  end
  jd.to_f
  vsop = VSOP87.new(data_set, jd)
  puts "#{data_set} at JD#{jd}"
  v_array = vsop.calc
  i = 0
  v_array.each do |v|
    puts "variable[#{i}] =  #{v}"
    i += 1
  end
else
  f = open('vsop87.txt')
  description = f.read
  f.close

  print <<EOS
============
Planetary positions by VSOP87 theory
============

DESCRIPTION
===========

Loading source files of VSOP87 and calculating positions of the planet at given julian day.

USAGE
=========

vsop87.rb?f=FILE_NAME(&d=JULIAN_DAY)

if you omit param "d" you will get current position.

REFERENCE
=========

VI/81 Planetary Solutions VSOP87 (Bretagnon+, 1988)
http://cdsarc.u-strasbg.fr/viz-bin/ftp-index?VI/81

Source Code
=========

http://www.lizard-tail.com/isana/lab/astro_calc/vsop87/vsop87_rb.txt

### Here is the description of VSOP87 files. ###

#{description}

EOS
end

=end

clock = Clock.new(DateTime.now.to_time.utc)
puts clock.the_variables(clock.date)
puts clock.date
puts clock.date.year
puts clock.date.month
puts clock.date.day
puts clock.date.to_datetime.jd
puts clock.date.to_datetime.ajd.to_f
puts clock.time
puts clock.time.hour
puts clock.time.min
puts clock.time.sec

=begin
README.planetmath:  Understanding Planetary Positions in KStars.
copyright 2002 by Jason Harris and the KStars team.
This document is licensed under the terms of the GNU Free Documentation License
-------------------------------------------------------------------------------


0. Introduction: Why are the calculations so complicated?

We all learned in school that planets orbit the Sun on simple, beautiful
elliptical orbits.  It turns out this is only true to first order.  It
would be precisely true only if there was only one planet in the Solar System,
and if both the Planet and the Sun were perfect point masses.  In reality,
each planet's orbit is constantly perturbed by the gravity of the other planets
and moons.  Since the distances to these other bodies change in a complex way,
the orbital perturbations are also complex.  In fact, any time you have more
than two masses interacting through mutual gravitational attraction, it is
*not possible* to find a general analytic solution to their orbital motion.
The best you can do is come up with a numerical model that predicts the orbits
pretty well, but imperfectly.


1. The Theory, Briefly

We use the VSOP ("Variations Seculaires des Orbites Planetaires") theory of
planet positions, as outlined in "Astronomical Algorithms", by Jean Meeus.
The theory is essentially a Fourier-like expansion of the coordinates for
a planet as a function of time.  That is, for each planet, the Ecliptic
Longitude, Ecliptic Latitude, and Distance can each be approximated as a sum:

  Long/Lat/Dist = s(0) + s(1)*T + s(2)*T^2 + s(3)*T^3 + s(4)*T^4 + s(5)*T^5

where T is the number of Julian Centuries since J2000.  The s(N) parameters
are each themselves a sum:

  s(N) = SUM_i[ A(N)_i * Cos( B(N)_i + C(N)_i*T ) ]

Again, T is the Julian Centuries since J2000.  The A(N)_i, B(N)_i and C(N)_i
values are constants, and are unique for each planet.  An s(N) sum can
have hundreds of terms, but typically, higher N sums have fewer terms.
The A/B/C values are stored for each planet in the files
<planetname>.<L/B/R><N>.vsop.  For example, the terms for the s(3) sum
that describes the T^3 term for the Longitude of Mars are stored in
"mars.L3.vsop".

Pluto is a bit different.  In this case, the positional sums describe the
Cartesian X, Y, Z coordinates of Pluto (where the Sun is at X,Y,Z=0,0,0).
The structure of the sums is a bit different as well.  See KSPluto.cpp
(or Astronomical Algorithms) for details.

The Moon is also unique, but the general structure, where the coordinates
are described by a sum of several sinusoidal series expansions, remains
the same.


2. The Implementation.

The KSplanet class contains a static OrbitDataManager member.  The
OrbitDataManager provides for loading and storing the A/B/C constants
for each planet.  In KstarsData::slotInitialize(), we simply call
loadData() for each planet.  KSPlanet::loadData() calls
OrbitDataManager::loadData(QString n), where n is the name of the planet.

The A/B/C constants are stored hierarchically:
 + The A,B,C values for a single term in an s(N) sum are stored in an
   OrbitData object.
 + The list of OrbitData objects that compose a single s(N) sum is
   stored in a QVector (recall, this can have up to hundreds of elements).
 + The six s(N) sums (s(0) through s(5)) are collected as an array of
   these QVectors ( typedef QVector<OrbitData> OBArray[6] ).
 + The OBArrays for the Longitude, Latitude, and Distance are collected
   in a class called OrbitDataColl.  Thus, OrbitDataColl stores all the
   numbers needed to describe the position of any planet, given the
   Julian Day.
 + The OrbitDataColl objects for each planet are stored in a QDict object
   called OrbitDataManager.  Since OrbitDataManager is static, each planet can
   access this single storage location for their positional information.
   (A QDict is basically a QArray indexed by a string instead of an integer.
   In this case, the OrbitDataColl elements are indexed by the name of the
   planets.)

Tree view of this hierarchy:

OrbitDataManager[QDict]: Stores 9 OrbitDataColl objects, one per planet.
|
+--OrbitDataColl: Contains all three OBArrays (for
   Longitude/Latitude/Distance) for a single planet.
   |
   +--OBArray[array of 6 QVectors]: the collection of s(N) sums for
      the Latitude, Longitude, or Distance.
      |
      +--QVector: Each s(N) sum is a QVector of OrbitData objects
         |
         +--OrbitData: a single triplet of the constants A/B/C for
            one term in an s(N) sum.

To determine the instantaneous position of a planet, the planet calls its
findPosition() function.  This first calls calcEcliptic(double T), which
does the calculation outlined above: it computes the s(N) sums to determine
the Heliocentric Ecliptic Longitude, Ecliptic Latitude, and Distance to the
planet.  findPosition() then transforms from heliocentric to geocentric
coordinates, using a KSPlanet object passed as an argument representing the
Earth.  Then the ecliptic coordinates are transformed to equatorial
coordinates (RA,Dec).  Finally, the coordinates are corrected for the
effects of nutation, aberration, and figure-of-the-Earth.  Figure-of-the-Earth
just means correcting for the fact that the observer is not at the center of
the Earth, rather they are on some point on the Earth's surface, some 6000 km
from the center.  This results in a small parallactic displacement of the
planet's coordinates compared to its geocentric position.  In most cases,
the planets are far enough away that this correction is negligible; however,
it is particularly important for the Moon, which is only 385 Mm (i.e.,
385,000 km) away.

=end

=begin

try: http://www.iausofa.org/2017_0420_C.html

=end
