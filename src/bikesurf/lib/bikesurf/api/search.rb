require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/helpers/date_helper'

module Bikesurf
  module Requests
    module Search
      include ::Bikesurf::Helpers::DateHelper
      def bike_search(from, to, size)
        from = date_of(from)
        to = date_of(to)

        reserved_ids = Database::ReservationController.instance.get_reserved_bike_ids(from, to)
        Database::BikeController.instance.free_bikes(reserved_ids, size)
      end

      def get_free_bikes(from_timestamp, to_timestamp, size)
        from_sql_datetime = timestamp_to_date(from_timestamp)
        to_sql_datetime = timestamp_to_date(to_timestamp)
        Database::ReservationController.instance.free_bikes(from_sql_datetime, to_sql_datetime, size)
      end
    end
  end
end
