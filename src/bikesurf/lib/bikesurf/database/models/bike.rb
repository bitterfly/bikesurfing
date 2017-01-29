require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class Bike
        include DataMapper::Resource

        property :id,                        Serial
        property :registration_number,       String
        property :name,                      String
        property :desctiption,               Text
        property :frame,                     Integer
        property :crossbar,                  Integer
        property :size,                      String
        property :front_lights,              String
        property :back_lights,               String
        property :backpedal_breaking_system, Boolean
        property :quick_release_saddle,      Boolean
        property :gears_number,              Integer
        property :min_borrow_days,           Integer
        property :max_borrow_days,           Integer

        belongs_to :stand
        has n, :reservations
      end
    end
  end
end
