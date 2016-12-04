$:.unshift("./lib").uniq!

require 'bikesurf_login/server'

run BikesurfLogin::Server
