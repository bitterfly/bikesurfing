require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'
require 'bikesurf/database/models/bike_image'

module Bikesurf
  module Database
    class BikeController
      include Singleton
      def get_by_id(id)
        #image_ids = Models::BikeImage.all(bike_id: id, :only=>[:image_id])
        image_ids = [1, 2, 3]
        image_files = Models::Image.all(id: image_ids, fields: [:filename])

        puts(image_ids)
        {
          bike: Models::Bike.get!(id),
          reservations: Models::Reservation.all(bike_id: id),
          images: Models::Image.all(bike_image: Models::BikeImage.all(bike_id: id))
        }
      end

      def get_all
        Models::Bike.all
      end
    end
  end
end
