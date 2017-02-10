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
        reservations = Models::Reservation.all(bike_id: id, status: 'accepted')
        dates = []
        reservations.each do |reservation|
          dates << [
            date_to_timestamp(reservation.from),
            date_to_timestamp(reservation.until)
          ]
        end

        {
          bike: Models::Bike.get!(id),
          reservations: dates
        }
      end

      def get_images_by_id(id)
        images = Models::Image.all(
          bike_image: Models::BikeImage.all(bike_id: id)
        )
        images.map do |image|
          {
            id: image.id,
            filename: image.filename
          }
        end
      end

      def create(bike_info)
        bike = Models::Bike.create(
          registration_number: bike_info['registration_number'],
          name: bike_info['name'],
          stand_id: bike_info['stand_id'],
          description: bike_info['description'],
          frame: bike_info['frame'],
          crossbar: bike_info['crossbar'],
          size: bike_info['size'],
          front_lights: bike_info['front_lights'],
          back_lights: bike_info['back_lights'],
          backpedal_breaking_system: bike_info['backpedal_breaking_system'],
          quick_release_saddle: bike_info['quick_release_saddle'],
          gears_number: bike_info['gears_number'],
          min_borrow_days: bike_info['min_borrow_days'],
          max_borrow_days: bike_info['max_borrow_days']
        )
        raise 'Faild to save. Bike must belong to a stand!' unless bike.saved?

        {
          bike: bike
        }
      end

      def update(bike_id, bike_info)
        bike = Models::Bike.get!(bike_id)
        bike.update(
          registration_number: bike_info['registration_number'],
          name: bike_info['name'],
          description: bike_info['description'],
          frame: bike_info['frame'],
          crossbar: bike_info['crossbar'],
          size: bike_info['size'],
          front_lights: bike_info['front_lights'],
          back_lights: bike_info['back_lights'],
          backpedal_breaking_system: bike_info['backpedal_breaking_system'],
          quick_release_saddle: bike_info['quick_release_saddle'],
          gears_number: bike_info['gears_number'],
          min_borrow_days: bike_info['min_borrow_days'],
          max_borrow_days: bike_info['max_borrow_days']
        )
      end

      def delete(bike_id)
        bike_to_delete = Models::Bike.get!(bike_id)
        bike_to_delete.destroy
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

      def filter(bikes, filters)
        bikes.all(filters)
      end
    end
  end
end
