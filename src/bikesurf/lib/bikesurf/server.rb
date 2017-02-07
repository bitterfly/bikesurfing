require 'rubygems'
require 'sinatra'
require 'bikesurf/config'
require 'bikesurf/api'
require 'bikesurf/database/setup'

module Bikesurf
  class Server < Sinatra::Base
    include Requests::Bike
    include Requests::Search

    set :public_folder, Config::PUBLIC
    set :show_exceptions, false
    # set :dump_errors, false

    # The before filter deserialises the json
    # if it follows the specification
    before do
      return unless request.post?
      request.body.rewind
      input = MultiJson.load request.body.read
      @data = input['data']
      @session_id = input['session_id']
      @timestamp = input['timestamp']
    end

    # When a crash occures this block is called
    # so if you want a custom error just implement to_json
    error do
      { ok: false, data: env['sinatra.error'] }.to_json
    end

    # This should be called before returning a value
    # to ensure conformance to the specification
    def respond(result)
      { ok: true, data: result }.to_json
    end

    get '/' do
      send_file File.expand_path(File.join(Config::PUBLIC, 'index.html'))
    end

    post '/api/bike/new' do
      result = insert_bike(@data['bike_info'])
      respond result
    end

    post '/api/bike/update' do
      result = update_bike(@data['bike_id'], @data['bike_info'])
      respond result
    end

    post '/api/bike/image/new' do
      result = insert_image(@data['bike_id'], @data['image'])
      respond result
    end

    post '/api/bike' do
      result = find_bike(@data['bike_id'])
      respond result
    end

    post '/api/comments/bike' do
      result = find_bike_comments(@data['bike_id'])
      respond result
    end

    post '/api/images/bike' do
      result = find_bike_images(@data['bike_id'])
      respond result
    end

    post '/api/bikes' do
      result = find_bikes
      respond result
    end

    post '/api/search_bikes' do
      respond fitting_criteria_bikes(@data)
    end

    get '/image/:filename' do
      filename = params['filename']
      if /[\w\d]*/ =~ filename
        return send_file(
          File.expand_path(
            File.join(ENV['IMAGES'], params['filename'])
          ),
          type: 'image/jpeg'
        )
      end
      status 403
      body 'Forbidden file'
    end
  end
end
