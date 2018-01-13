#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# Given the celestial coordinates in the declination-ascension, script to indicate whether it is in any position with respect to a particular location on the Earth
#
####################
# Change log
####################
#
# YYMMDD ver.  author  content
# XXXXXX 1.0   hikaru  It was to make it work
# 141129 1.1   hikaru The option was to be processed by the block. Add the -s option.
# 150123 1.2   hikaru It changed the program name. radec.rb-> pointObject.rb
# 150201 1.2.1 hikaru Fixed variables and function names. In assuming Observatory is the culmination perfect noon. 
# 150201 1.3.0 hikaru Reckoned in UTC all the time. It was to choose their favorite stations to convert the information of the observatory.

require "opengl"
require "glut"
require "matrix"
require "optparse"
require "glu"

###########
# Variable Toka
###########
MonthToDay = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
ObservatoryLat = 41.9475 # Observatory Lat
ObservatoryLon = -88.743 # Observatory Lon
ObservatoryRadius = 900 + 640000 # Observatory advanced + radius of the Earth
ObservatoryTimeOffset = 60 * 60 * -6 # Japan utc + 09: 00: 00

#########
# function
#########

def rad
  Math::PI / 180.0
end

def DegToRad(deg)
  deg.to_f * rad
end

def cycle
  2 * Math::PI
end

timer = proc {
  GL.Rotate(1.0, 0.0, 1.0, 0.0)
  GLUT.PostRedisplay()
  GLUT.TimerFunc(10, timer, 0)
}

def Observatory(tday)
  # GL.Begin(GL::GL_POINTS)
  GL.Color3f(1.0, 1.0, 0.0)
  day = tday
  # print day
  # day = Time.local(2000,3,23,12,0,0) # For debugging. Specify the vernal equinox.
  decc = cycle / 360.to_f * ObservatoryLat
  # Number of days of 82 from the beginning of the year up to 3/23. 
  # The current position of the Greenwich Observatory.
  raa = cycle * ((MonthToDay[((day.month).to_i - 1)] + day.day - 82)).to_f / 365.0 
  raa += cycle * ObservatoryLon / 365.0 # The minute rotation of the observatory longitude.
  # Whether you are further rotated many times, think on the assumption that the sun to culmination at noon.
  raa = raa + cycle * ((day.hour - 12) * 15 + day.min * 0.25) / 360.to_f
  MakeSphere(0.1, 0.01, raa, decc);
  # GL.End()
end

def Celestial()
  GL.Color3d(1.0, 1.0, 1.0)
  GLUT.WireSphere(1.0, 20.0, 20.0)
end

def OrbitCelestial()
  GL.Color3f(1.0, 1.0, 1.0)
  GLUT.WireSphere(0.5, 10.0, 10.0)
end

def Sun(tday)
  # GL.Begin(GL::GL_POINTS)   
  GL.Color3f(1.0, 1.0, 0.0)
  GLUT.WireSphere(0.1, 10.0, 10.0)
  day = tday
  #print day,"\n"
  day += ObservatoryTimeOffset #Observatory is given in seconds, or are offset much against UTC.
  #day = day.local
  raa = cycle * ((MonthToDay[((day.month).to_i - 1)] + day.day - 82)).to_f / 365.0
  sunDec = 23.5 * rad
  #decc = 0
  if  raa % 180 == 0 && raa % 90 == 0 then
    decc = 0
  end
  if raa % 180 != 0 && raa % 90 == 0 && raa % 270 != 0 then
    decc = 23.5
  end
  if raa % 180 !=0 && raa % 90 == 0 && raa % 270 == 0 then
    decc = -23.5
  end
  if raa % 180 !=0 && raa % 90 != 0 then

    dir1 = Vector[1 / Math.tan(raa), 1, Math.tan(sunDec)]
    dir2 = Vector[1 / Math.tan(raa), 1, 0]
    decc = Math.acos((dir1.inner_product(dir2)).to_f / (dir1.r * dir2.r).to_f)

    # decc always becomes positive. Caution. Correction under.    
    if raa > Math::PI or raa < 0 then 
      decc = -decc
    end
    
  end
  
  #p raa,decc
  # Specify the color
  GL.Color3d(1.0, 1.0, 0.0)
  # Make a sphere on the position of celestial bodies.
  MakeSphere(0.5, 0.1, raa, decc)
  #p raa,decc
  # GL.End()
end

def Object()
  # GL.Begin(GL::GL_POINTS)
  # Specify the color
  GL.Color3d(1.0, 0.0, 0.0)
  # Make a sphere on the position of celestial bodies.
  MakeSphere(1.0, 0.1, RA, DEC)
  # GL.End()
end

def Earth()
  GL.Begin(GL::GL_POINTS) 
  # Earth's ascension from the current time, get a declination
  # Specify the color
  GL.Color3f(0.0, 0.0, 1.0)  
  # GLUT.WireSphere(0.1, 10.0, 10.0)
  day = Time.now
  raa = 2 * Math::PI * ((MonthToDay[((day.month).to_i - 1)] + day.day - 91)).to_f / 365.0 + Math::PI
  decc = 0 # Declination 0
  # Specify the color
  #p raa,decc
  GL.Color3d(0.0, 0.0, 1.0)
  # Make a sphere on the position of celestial bodies.
  MakeSphere(0.5, 0.1, raa, decc)
  #p raa,decc
  GL.End()
end

# Make a sphere at the point
def MakeSphere(positionR, radius, ra, dec)
  pointNum = 100
  i = 0
  while i < pointNum do
    j = 0
    while j < pointNum do
      l_theta = cycle * i.to_f / pointNum.to_f
      l_phi = cycle * j.to_f / pointNum.to_f

      # Central coordinate
      x = positionR * Math.cos(ra)  *Math.cos(dec)
      y = positionR * Math.sin(ra) * Math.cos(dec)
      z = positionR * Math.sin(dec)

      # Each point
      x = x + radius * Math.cos(l_phi) * Math.sin(l_theta)
      y = y + radius * Math.sin(l_phi) * Math.sin(l_theta)
      z = z + radius * Math.cos(l_theta)

      # To rotate the coordinate
      zz =- x # Go well and for some reason put minus.
      xx = y
      yy = z

      # plot
      GL.Vertex3d(xx, yy, zz)
      j = j + 1
    end
    i = i + 1
  end
end

# Function to write the axis
def DrawAxis()
  # axis[4][3] = [[0.0, 0.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
  GL.Begin(GL::GL_LINES);
  # x axis
  GL.Color3dv(1.0, 0.0, 0.0)
  GL.Vertex3dv(0.0, 0.0, 0.0)
  GL.Vertex3dv(0.0, 0.0, -2.0)
  # y axis
  GL.Color3dv(0.0, 1.0, 0.0)
  GL.Vertex3dv(0.0, 0.0, 0.0)
  GL.Vertex3dv(2.0, 0.0, 0.0)
  # z axis
  GL.Color3dv(0.0, 0.0, 1.0)
  GL.Vertex3dv(0.0, 0.0, 0.0)
  GL.Vertex3dv(0.0, 2.0, 0.0)
  GL.End()
end


###
# Processing at the time of the end.
###
Signal.trap(:INT){
  print("
I received Ctrl+C.
Terminate this program.
")
  exit(0)
}

def PrintMessage()
  str = sprintf("
big blue     : Earth
small yellow : Observatory (Lat:%f, Lon:%f)
big yellow   : Sun
big red      : Object
Large blue   : Celestial Sphere

Please press Ctrl+c if you want to terminate this program.
",ObservatoryLat,ObservatoryLon)
  print(Time.now.utc, str)
end

def my_sphere
  # GL.Begin(GL::GL_POINTS)  
  day = Time.now
  raa = cycle * (day.sec)
  GL.Color3d(1.0, 1.0, 1.0)
  MakeSphere(0.6, 0.4, 0,0)
  # GL.End()
end

display = proc {
  day = Time.now.utc
  GL.Clear(GL::COLOR_BUFFER_BIT)
  Celestial()
  # OrbitCelestial()
  Sun(day)
  # GL.Translated(0.0, 0, 0.01)
  # Object()
  Earth()
  # Observatory(day)
  # DrawAxis()
  # my_sphere()
  GLUT.SwapBuffers()
}

##########
# main
##########
if __FILE__ == $0
  opts = {}
  # Setting of argument
  # Match since coordinate system is different
  ARGV.options do |o|
    o.on("-r X", "--ra", "Right Accension [deg]"){|x| opts[:ra] = x}
    o.on("-d X", "--dec", "Declination [deg]"){|x| opts[:dec] = x}
    o.on("-s", "--stop", "Stop Spin"){|x| opts[:spin] = x}
    o.parse!
  end
  

  RA = DegToRad(opts[:ra].to_f)
  DEC = DegToRad(opts[:dec].to_f)
  # Setting of argument
  PrintMessage()
  # Initialization of GLUT and OpenGL environment
  GLUT.Init()
  GLUT.InitWindowSize(800, 800)
  # Open a window. The argument is the name.
  GLUT.CreateWindow("Celestial Dome")
  # the point of view of the camera
  # gluLookAt(1,0, 0, 0, 0, 0, 0, 1, 0)
  # Take a pointer to a function as an argument. Describing its function.
  GLUT.DisplayFunc(display)
  # Specify the color fill the window. R, G, B, transparency.
  GL.ClearColor(0.0, 0.0, 0.0, 0.0)

  if true!=opts[:spin]
    GLUT.TimerFunc(10, timer, 0)
  end

  # just my experiments
  # day = Time.now.utc
  # p raa = cycle * ((MonthToDay[((day.month).to_i - 1)] + day.day - 91)).to_f / 365.0 + Math::PI

  #infinite loop. Calling this function, the program will be in a wait state of the event.
  GLUT.MainLoop()
  
end