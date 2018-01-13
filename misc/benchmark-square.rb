require 'benchmark'

t = 36_525.0
p t**2
p t * t
p t.modulo(360.0)
p t.divmod(360.0)[1]
p t % 360.0
n = 5_000_000
Benchmark.bm(7) do |x|
  x.report('t**2:') { n.times { ; t**2; } }
  x.report('t * t:') { n.times { ; t * t; } }
  x.report('modulo:') { n.times { ; t.modulo(365.25); } }
  x.report('divmod:') { n.times { ; t.divmod(365.25)[1]; } }
  x.report('%:') { n.times { ; t % 365.25; } }
end
