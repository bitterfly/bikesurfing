require 'sinatra'
require 'bikesurf/config'

module Bikesurf
  class Server < Sinatra::Base
    set :public_folder, Config::Public

    get '/' do
      redirect '/index.html'    # fixme: this is stupid, don't redirect
    end
  end
end
