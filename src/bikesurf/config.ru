$:.unshift("./lib").uniq!

require 'bikesurf/server'

run Bikesurf::Server
