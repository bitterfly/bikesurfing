require 'sinatra'
require 'bikesurf/config'

module Bikesurf
  class Server < Sinatra::Base
    set :bind, '0.0.0.0'
    set :server, 'thin'
    set :public_folder, Config::Public

    get '/' do
      'Hello world!'
      # ENV["TEST_ENV"]
    end
  end
end
