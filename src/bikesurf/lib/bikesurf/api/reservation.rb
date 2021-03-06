require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/helpers/date_helper'
require 'bikesurf/images/image'
require 'dotenv/load'
require 'bikesurf/config'
require 'base64'

module Bikesurf
  module Requests
    module Reservation
      include ::Bikesurf::Helpers::DateHelper

      def reservation(reservation_id)
        Database::ReservationController.instance.get_by_id reservation_id
      end

      def user_reservations(user)
        Database::ReservationController.instance.get_by_user user
      end

      def update_reservation_status(reservation_id, status)
        raise unless ['accepted', 'declined'].include? status
        Database::ReservationController.instance.update_status(
          reservation_id, status
        )
      end

      def create_reservation(user_id, from, to, bike_id, comment)
        reservation_id = Database::ReservationController.instance.create(
          timestamp_to_date(from),
          timestamp_to_date(to),
          user_id,
          bike_id
        ).id

        Database::CommentController.instance.create_reservation_comment(
          user_id,
          reservation_id,
          comment
        )
        {
          id: reservation_id
        }
      end

      def create_reservation_comment(user_id, reservation_id, comment)
        Database::CommentController.instance.create_reservation_comment(
          user_id,
          reservation_id,
          comment
        )
      end

      def reservation_comments(reservation_id)
        Database::ReservationController.instance.get_comments_by_id reservation_id
      end
    end
  end
end
