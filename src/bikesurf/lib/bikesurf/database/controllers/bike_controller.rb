require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'
require 'bikesurf/database/models/bike_image'
require 'bikesurf/helpers/date_helper'

module Bikesurf
  module Database
    class BikeController
      include ::Bikesurf::Helpers::DateHelper
      include Singleton
      def get_by_id(id)
        {
          bike: Models::Bike.get!(id),
          reservations: Models::Reservation.all(bike_id: id)
        }
      end

      def get_images_by_id(id)
        images = Models::Image.all(
          bike_image: Models::BikeImage.all(bike_id: id)
        )
        images.map do |image|
          {
            filename: image.filename
          }
        end
      end

      def update(bike_id, bike_info)
        property :id,                        Serial
        property :registration_number,       String
        property :name,                      String
        property :desctiption,               Text
        property :frame,                     Integer
        property :crossbar,                  Integer
        property :size,                      String
        property :front_lights,              String
        property :back_lights,               String
        property :backpedal_breaking_system, Boolean
        property :quick_release_saddle,      Boolean
        property :gears_number,              Integer
        property :min_borrow_days,           Integer
        property :max_borrow_days,           Integer
        bike = Models::Bike.get!(bike_id)
        bike.update(
          registration_number: bike_info['registration_number'],
          name: bike_info['name'],
          desctiption: bike_info['desctiption'],
          frame: bike_info['frame'],
          crossbar: bike_info['crossbar'],
          size: bike_info['size'],
          front_lights: bike_info['front_lights'],
          back_lights: bike_info['back_lights'],
          backpedal_breaking_system: bike_info['backpedal_breaking_system'],
          quick_release_saddle: bike_info['quick_release_saddle'],
          gears_number: bike_info['gears_number'],
          min_borrow_days: bike_info['min_borrow_days'],
          max_borrow_days: bike_info['max_borrow_days'],
        )
      end

      def get_comments_by_id(id)
        comments = Models::Comment.all(
          bike_comment: Models::BikeComment.all(bike_id: id)
        )

        comments.map do |comment|
          {
            id: comment.id,
            message: comment.message,
            post_time: date_to_timestamp(comment.post_time),

            user: {
              id: comment.user.id,
              name: comment.user.name,
              username: comment.user.username,
              avatar: comment.user.image
            }
          }
        end
      end

      def all
        Models::Bike.all
      end

      def not_matching(ids)
        Models::Bike.all(:id.not => reserved_ids)
      end
    end
  end
end
