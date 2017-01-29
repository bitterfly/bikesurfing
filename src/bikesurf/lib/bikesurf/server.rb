require 'sinatra'
require 'bikesurf/config'

module Bikesurf
  class Server < Sinatra::Base
    set :public_folder, Config::PUBLIC

    get '/' do
      redirect '/index.html' # FIXME: this is stupid, don't redirect
    end
  end
end
