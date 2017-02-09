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

      def bikes_meeting_the_requirements(requirements)
        raise 'Please, select from date.' unless requirements['from']
        raise 'Please, select to date.' unless requirements['to']

        bikes = free_bikes(requirements['from'], requirements['to'])
        filters = extract_filters(requirements)
        Database::BikeController
          .instance
          .filter(bikes, filters)
      end

      def extract_filters(requirements)
        allowed_filters = %w(size front_lights back_lights gears_number
                             backpedal_breaking_system quick_release_saddle)
        filters = requirements.select do |key, value|
          allowed_filters.include?(key) || !value.to_s.empty?
        end
        # should add min and max borrow days creteria as well
        filters
      end
    end
  end
end
