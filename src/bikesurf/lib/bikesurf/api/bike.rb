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

      def update_bike(bike_id, bike_info)
        Database::BikeController.instance.update(bike_id, bike_info)
      end

      def create_bike(bike_info)
        Database::BikeController.instance.create bike_info
      end

    end
  end
end
