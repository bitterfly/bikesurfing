require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'

module Bikesurf
  module Database
    class ReservationController
      include Singleton

      def get_reserved_bike_ids(from, to)
        Models::Reservation.all(fields: [:id])
      end
    end
  end
end
