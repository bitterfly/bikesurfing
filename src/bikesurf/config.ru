require_relative './lib/bikesurf/server'

require 'dotenv'
Dotenv.load

run Bikesurf::Server
