# Support for environment variables, should be the first thing to load
require 'dotenv'
Dotenv.load

require_relative './lib/bikesurf/server'

run Bikesurf::Server
