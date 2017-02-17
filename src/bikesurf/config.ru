# Support for environment variables, should be the first thing to load
require 'dotenv'
Dotenv.load

# Use require with path relative to /lib
$LOAD_PATH.unshift('./lib').uniq!

require 'bikesurf/server'

run Bikesurf::Server
