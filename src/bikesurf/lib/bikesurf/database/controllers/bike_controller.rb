require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/reservation'
require 'bikesurf/database/models/bike_image'
require 'bikesurf/helpers/date_helper'
require 'bikesurf/database/controllers/comment_controller'

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
        bike = Models::Bike.get!(id)
        {
          bike: bike,
          reservations: dates,
          owner: {
            id: bike.stand.user.id,
            username: bike.stand.user.username,
            name: bike.stand.user.name,
            avatar: bike.stand.user.image
          }
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

        bike
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

        CommentController.instance.info_from_comments comments
      end

      def all
        Models::Bike.all
      end

      def remove_nils(requirements)
        requirements.select do |_key, value|
          !value.to_s.empty?
        end
      end

      def filter(bikes, filters)
        borrow_duration = day_difference(
          timestamp_to_date(filters['from']),
          timestamp_to_date(filters['to'])
        )
        filtered_bikes = bikes.all(
          remove_nils(
            :min_borrow_days.lte => borrow_duration,
            :max_borrow_days.gte => borrow_duration,
            size: filters['size'],
            :front_lights.like => "#{filters['front_lights']}%",
            :back_lights.like => "#{filters['back_lights']}%",
            backpedal_breaking_system: filters['backpedal_breaking_system'],
            quick_release_saddle: filters['quick_release_saddle'],
            :gears_number.gte => filters['min_gears']
          )
        )

        filtered_bikes.each do |bike|

        end
      end
    end
  end
end
