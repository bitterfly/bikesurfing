require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/helpers/date_helper'
require 'bikesurf/database/controllers/bike_image_controller'

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
        process_filters(requirements)

        Database::BikeController
          .instance
          .filter(bikes, requirements)
      end

      def free_bikes_meeting_the_requirements_with_image(requirements)
        filtered_bikes = free_bikes_meeting_the_requirements(requirements)
        filtered_bikes.map do |bike|
          {
            bike: bike,
            image: Database::BikeImageController
              .instance.bike_image(bike.id)
          }
        end
      end

      def process_filters(requirements)
        ['front_lights', 'back_lights'].each do |property|
          unless requirements[property].nil?
            requirements[property] = requirements[property] ? 'y' : 'n'
          end

        end
      end
    end
  end
end
