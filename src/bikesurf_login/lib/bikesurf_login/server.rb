require 'sinatra'
require 'bikesurf_login/config'

module BikesurfLogin
  class Server < Sinatra::Base
    set :bind, '0.0.0.0'
    set :server, 'thin'

    get '/' do
      'Hello world!'
    end
  end
end
