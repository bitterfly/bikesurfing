require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'

module Bikesurf
  module Database
    class BikeController
      include Singleton
      def get_by_id(id)
        {
          bike: Models::Bike.get!(id),
          reservations: Models::Reservation.all(bike_id: id)
        }
      end

      def get_all
        Models::Bike.all
      end

      def free_bikes(reserved_ids, size)
        Models::Bike.all(:size => size, :id.not => reserved_ids)
      end
    end
  end
end
