require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/images/image'
require 'dotenv/load'
require 'bikesurf/config'
require 'base64'

module Bikesurf
  module Requests
    module Reservation
      def get_reservation(reservation_id)
        Database::ReservationController.instance.get_by_id reservation_id
      end

      def get_user_reservations(user)
        Database::ReservationController.instance.get_by_user user
      end

      def create_reservation(user, from, to, bike_id, comment)
        reservation_id = Database::ReservationController.instance.create(
          from,
          to,
          user.id,
          bike_id
        ).id
        Database::CommentController.instance.create_reservation_comment(
          reservation_id,
          message
        )
        reservation_id
      end
    end
  end
end
