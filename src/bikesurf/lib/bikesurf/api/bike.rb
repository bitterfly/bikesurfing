require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/api/image'

module Bikesurf
  module Requests
    module Bike
      include ::Bikesurf::Requests::Image

      def bike(id)
        Database::BikeController.instance.get_by_id id
      end

      def all_bikes
        Database::BikeController.instance.get_all
      end

      def bike_images(bike_id)
        Database::BikeController.instance.get_images_by_id bike_id
      end

      def bike_comments(bike_id)
        Database::BikeController.instance.get_comments_by_id bike_id
      end

      def update_bike(bike_id, bike_info)
        Database::BikeController.instance.update(bike_id, bike_info)
      end

      def create_bike(bike_info)
        Database::BikeController.instance.create bike_info
      end

      def delete_bike(bike_id)
        delete_bike_images(bike_id)
        Database::BikeController.instance.delete bike_id
      end

      def bike_comment_create(user_id, bike_id, comment)
        Database::CommentController.instance.create_bike_comment(
          user_id,
          bike_id,
          comment
        )
      end
    end
  end
end
