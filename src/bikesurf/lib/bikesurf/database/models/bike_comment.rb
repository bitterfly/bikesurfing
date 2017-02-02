require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class BikeComment
        include DataMapper::Resource

        property :id, Serial

        belongs_to :comment
        belongs_to :bike
      end
    end
  end
end
