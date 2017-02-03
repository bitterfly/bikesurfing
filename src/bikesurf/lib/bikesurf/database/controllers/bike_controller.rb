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
        {
          images: Models::Image.all(bike_image: Models::BikeImage.first(bike_id: id))
        }
      end

      def get_comments_by_id(id)
        comments = Models::Comment.all(bike_comment: Models::BikeComment.first(bike_id: id))
        
        fyck = []
        comments.each do |comment|
         fyck << {
            comment: comment,
            user: comment.user
          }
        end
        {comments: fyck}
      end

      def get_all
        Models::Bike.all
      end
    end
  end
end
