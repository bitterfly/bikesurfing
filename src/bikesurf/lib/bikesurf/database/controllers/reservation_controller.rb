require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'

module Bikesurf
  module Database
    class ReservationController
      include Singleton

      def reserved_bikes(from, to)
        Models::Bike.all(
          reservations: Models::Reservation.all(
            :from.lte => to,
            :until.gte => from,
            status: 'accepted'
          )
        )
      end

      def free_bikes(from, to)
        Models::Bike.all - reserved_bikes(from, to)
      end
    end
  end
end
