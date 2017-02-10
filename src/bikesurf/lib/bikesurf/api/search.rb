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

      # def extract_filters(requirements)
      #   allowed_filters = %w(size front_lights back_lights gears_number
      #                        backpedal_breaking_system quick_release_saddle)

      #   requirements.select do |key, value|
      #     allowed_filters.include?(key) && !value.to_s.empty?
      #   end
      # end
    end
  end
end
