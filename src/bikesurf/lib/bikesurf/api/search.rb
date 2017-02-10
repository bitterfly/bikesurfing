require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/helpers/date_helper'

module Bikesurf
  module Requests
    module Search
      include ::Bikesurf::Helpers::DateHelper

      def free_bikes(from, to)
        Database::ReservationController
          .instance
          .free_bikes(
            timestamp_to_date(from),
            timestamp_to_date(to)
          )
      end

      def free_bikes_meeting_the_requirements(requirements)
        bikes = free_bikes(requirements['from'], requirements['to'])
        # filters = extract_filters(requirements)
        Database::BikeController
          .instance
          .filter(bikes, requirements)
      end

    end
  end
end
