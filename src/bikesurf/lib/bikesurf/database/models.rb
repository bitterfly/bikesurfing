require 'rubygems'
require 'data_mapper'
require 'dotenv/load'

module Bikesurf
	module Database
    DataMapper.setup(:default, ENV["DATABASE_URN"])

    class Bike
      include DataMapper::Resource

      property :id,                        Serial
      property :registration_number,       String
      property :name,                      String
      property :desctiption,               Text
      property :frame,                     Integer
      property :crossbar,                  Integer
      property :front_lights,              String
      property :back_lights,               String
      property :backpedal_breaking_system, Boolean
      property :quick_release_saddle,      Boolean
      property :gears_number,              Integer
    end

    DataMapper.finalize
  end
end