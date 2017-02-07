require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike_image'
require 'bikesurf/database/models/bike'

module Bikesurf
  module Database
    class BikeImageController
      include Singleton

      def add(bike_id, image)
        Models::BikeImage.create(
          bike_id: bike_id,
          image: image
        )
        {
          image: image
        }
      end
    end
  end
end
