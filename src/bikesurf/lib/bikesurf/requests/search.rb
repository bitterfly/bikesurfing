require 'rubygems'
require 'bikesurf/database/controllers'

module Bikesurf
  module Requests
    module Search
      def bike_search(from, to, size)
        reserved_ids = Database::ReservationController.instance.get_reserved_bike_ids(from, to)
        Database::BikeController.instance.free_bikes(reserved_ids, size)
      end

      def find_bikes
        Database::BikeController.instance.get_all
      end
    end
  end
end
