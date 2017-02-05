require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'
require 'bikesurf/database/models/bike_image'

module Bikesurf
  module Database
    class BikeController
      include Singleton
      def get_by_id(id)
        {
          bike: Models::Bike.get!(id),
          reservations: Models::Reservation.all(bike_id: id),
        }
      end

      def get_images_by_id(id)
        images = Models::Image.all(bike_image: Models::BikeImage.all(bike_id: id))
        images.map do |image|
          {
            filename: image.filename
          }
        end
      end

      def get_comments_by_id(id)
        comments = Models::Comment.all(bike_comment: Models::BikeComment.all(bike_id: id))

        comments.map do |comment|
          {
            id: comment.id,
            message: comment.message,
            post_time: comment.post_time, # todo: convert to proper timestamp

            user: {
              id: comment.user.id,
              name: comment.user.name,
              username: comment.user.username
            }
          }
        end
      end

      def get_all
        Models::Bike.all
      end

      def not_matching(ids)
        Models::Bike.all(:id.not => reserved_ids)
      end
    end
  end
end
