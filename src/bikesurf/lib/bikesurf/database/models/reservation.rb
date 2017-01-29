require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class Reservation
        include DataMapper::Resource

        property :id,            Serial
        property :until,         Date
        property :from,          Date
        property :pick_up_time,  DateTime

        belongs_to :bike
        belongs_to :user
      end
    end
  end
end