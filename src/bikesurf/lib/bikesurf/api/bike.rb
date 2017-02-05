require 'rubygems'
require 'bikesurf/database/controllers'

module Bikesurf
  module Requests
    module Bike
      def find_bike(data)
        Database::BikeController.instance.get_by_id data
      end

      def find_bikes
        Database::BikeController.instance.get_all
      end

      def find_bike_images(data)
        Database::BikeController.instance.get_images_by_id data
      end

      def find_bike_comments(data)
        Database::BikeController.instance.get_comments_by_id data
      end
    end
  end
end
