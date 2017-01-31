require 'sinatra'
require 'bikesurf/config'
require 'bikesurf/requests'

module Bikesurf
  class Server < Sinatra::Base
    include Requests::Bike

    set :public_folder, Config::PUBLIC
    set :show_exceptions, false
    set :dump_errors, false

    # The before filter deserialises the json
    # if it follows the specification
    before do
      request.body.rewind
      input = JSON.parse request.body.read
      @data = input['data']
      @session_id = input['session_id']
      @timestamp = input['timestamp']
    end

    # When a crash occures this block is called
    # so if you want a custom error just implement to_json
    error do
      {ok: false, data: env['sinatra.error']}.to_json
    end

    # This should be called before returning a value
    # to ensure conformance to the specification
    def respond result
      {ok: true, data: result}.to_json
    end

    get '/' do
      redirect '/index.html' # FIXME: this is stupid, don't redirect
    end

    post '/api/bike' do
      result = find_bike(@data['bike_id'])
    	respond result
    end
  end
end
