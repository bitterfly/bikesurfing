require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'

module Bikesurf
  module Database
    class ReservationController
      include Singleton

      def free_bikes(from, to, size)
        all_bikes_of_size = Models::Bike.all(size: size)

        reserved_bikes = Models::Bike.all(
          reservations: Models::Reservation.all(
            :from.lte => to,
            :until.gte => from
          )
        )
        
        {
          bikes: all_bikes_of_size - reserved_bikes
        }
      end
    end
  end
end
