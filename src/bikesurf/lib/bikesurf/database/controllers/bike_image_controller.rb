require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike_image'

module Bikesurf
  module Database
    class BikeImageController
      include Singleton
      
      def add(bike, image)
        Models::BikeImageImage.create(
          bike: bike,
          image: image
        )
      end
    end
  end
end
