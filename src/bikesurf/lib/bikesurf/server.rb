require 'rubygems'
require 'sinatra'
require 'bikesurf/config'
require 'bikesurf/api'
require 'bikesurf/database/setup'

module Bikesurf
  class Server < Sinatra::Base
    include Requests::Bike
    include Requests::Search
    include Requests::Image
    include Requests::Session
    include Requests::Reservation

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
      @user = get_user_by_session @session_id
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

    post '/api/login' do
      result = login(@data['username'], @data['password'])
      respond result
    end

    post '/api/logout' do
      result = logout(@session_id)
      respond result
    end

    post '/api/whoami' do
      return respond nil unless @user
      data = {
        id: @user.id,
        name: @user.name,
        username: @user.username,
        avatar: @user.image
      }
      respond data
    end

    post '/api/bikes' do
      result = all_bikes
      respond result
    end

    post '/api/bike' do
      result = bike(@data['bike_id'])
      respond result
    end

    post '/api/bike/create' do
      result = create_bike(@data['bike_info'])
      respond result
    end

    post '/api/bike/update' do
      result = update_bike(@data['bike_id'], @data['bike_info'])
      respond result
    end

    post '/api/bike/delete' do
      result = delete_bike(@data['bike_id'])
      respond result
    end

    post '/api/bike/image/new' do
      puts @data['bike_id']
      result = insert_image(@data['bike_id'], @data['image'])
      respond result
    end

    post '/api/bike/image/delete' do
      result = delete_image(@data['bike_id'], @data['image_id'])
      respond result
    end

    post '/api/bike/comments' do
      result = bike_comments(@data['bike_id'])
      respond result
    end

    post '/api/bike/comment/create' do
      result = bike_comment_create(@user.id, @data['bike_id'], @data['comment'])
      respond result
    end

    post '/api/reservation/comments' do
      result = reservation_comments(@data['reservation_id'])
      respond result
    end

    post '/api/reservation/comment/create' do
      result = reservation_comment_create(@user.id, @data['reservation_id'], @data['comment'])
      respond result
    end

    post '/api/images/bike' do
      result = bike_images(@data['bike_id'])
      respond result
    end

    post '/api/reservation/create' do
      result = create_reservation(
        @user.id,
        @data['from'],
        @data['to'],
        @data['bike_id'],
        @data['comment']
      )
      respond result
    end

    post '/api/bikes' do
      result = all_bikes
      respond result
    end

    post '/api/bikes/search' do
      # data should have 'from', 'to' dates
      # data could have 'size', 'front_lights', 'back_lights',
      #                 'backpedal_breaking_system', 'quick_release_saddle',
      #                 'min_gears'
      result = free_bikes_meeting_the_requirements(@data)
      respond result
    end

    post '/api/reservation' do
      result = reservation(@data['reservation_id'])
      respond result
    end

    post '/api/user/reservations' do
      return respond nil unless @user
      result = user_reservations(@user)
      respond result
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
