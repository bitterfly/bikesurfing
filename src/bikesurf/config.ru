# Support for environment variables, should be the first thing to load
require 'dotenv'
Dotenv.load

# Use require with path relative to /lib
$:.unshift("./lib").uniq!

require 'bikesurf/server'

run Bikesurf::Server
