require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike_image'
require 'bikesurf/database/models/bike'

module Bikesurf
  module Database
    class BikeImageController
      include Singleton
      
      def add(bike_id, image)
        bike = Models::Bike.get(bike_id)
        Models::BikeImageImage.create(
          bike_id: bike_id,
          image: image
        )
      end
    end
  end
end
