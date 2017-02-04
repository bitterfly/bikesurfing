require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class ReservationComment
        include DataMapper::Resource

        property :id, Serial

        belongs_to :comment
        belongs_to :reservation
      end
    end
  end
end
