require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/helpers/date_helper'

module Bikesurf
  module Requests
    module Search
      def bike_search(from, to, size)
        from = date_of(from)
        to = date_of(to)

        reserved_ids = Database::ReservationController.instance.get_reserved_bike_ids(from, to)
        Database::BikeController.instance.free_bikes(reserved_ids, size)
      end

      def get_free_bikes(from, to, size)
        from_date = Helpers::DateHelper.timestamp_to_date(from)
        to_date = Helpers::DateHelper.timestamp_to_date(to)
        Database::ReservationController.instance.free_bikes(from_date, to_date, size)
      end
    end
  end
end
