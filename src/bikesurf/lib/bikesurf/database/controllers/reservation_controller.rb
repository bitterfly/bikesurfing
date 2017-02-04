require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'

module Bikesurf
  module Database
    class ReservationController
      include Singleton

      def free_fitting_criteria_bikes(from, to, criteria)
        {
          bikes: bikes_fitting_criteria(criteria) - reserved_bikes(from, to)
        }
      end

      private

      def reserved_bikes(from, to)
        Models::Bike.all(
          reservations: Models::Reservation.all(
            :from.lte => to,
            :until.gte => from
          )
        )
      end

      def free_bikes(from, to)
        Models::Bike.all - reserved_bikes(from, to)
      end

      def bikes_fitting_criteria(criteria)
        Models::Bike.all(criteria)
      end
    end
  end
end
