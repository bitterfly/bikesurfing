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

      def get_reservation(reservation_id)
        Database::ReservationController.instance.get_by_id reservation_id
      end

      def get_user_reservations(user)
        Database::ReservationController.instance.get_by_user user
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
    end
  end
end
