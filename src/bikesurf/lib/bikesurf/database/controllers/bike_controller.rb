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
        {
          bike: Models::Bike.get!(id),
          reservations: Models::Reservation.all(bike_id: id),
          image: Models.BikeImage.all(bike_id: id)
        }
      end

      def get_all
        Models::Bike.all
      end
    end
  end
end
