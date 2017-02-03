require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class BikeImage
        include DataMapper::Resource

        property :id, Serial

        belongs_to :image
        belongs_to :bike
      end
    end
  end
end