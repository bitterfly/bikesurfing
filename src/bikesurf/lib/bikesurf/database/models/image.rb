require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class Image
        include DataMapper::Resource

        property :id,       Serial
        property :filename, Text

        has 1, :bike_image
        has 1, :user
      end
    end
  end
end
