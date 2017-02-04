require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'

module Bikesurf
  module Database
    class ReservationController
      include Singleton

      def free_bikes(from, to, size)
        # Models::Reservation.all(fields: [:id])
        # Models::Bike.all(reservation: Models::Reservation.all(:from.gt => to))
        all_bikes = Models::Bike.all
        # reserved_bikes = Models::Bike.all(
        #   reservations: Models::Reservation.all(
        #     conditions: [
        #       'bikesurf_database_models_reservations.from >= ? or bikesurf_database_models_reservations.until <= ?', to, from
        #     ]
        #   )
        # )

        reserved_bikes = Models::Bike.all(
          conditions: [
            'size = ? or size = ?', "medium", "small"
          ]
        )

        
        {
          bikes: reserved_bikes
        }
      end
    end
  end
end
