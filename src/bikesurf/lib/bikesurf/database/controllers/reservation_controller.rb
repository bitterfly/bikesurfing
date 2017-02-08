require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/user'
require 'bikesurf/database/models/bike_image'
require 'bikesurf/database/models/reservation'

module Bikesurf
  module Database
    class ReservationController
      include Singleton

      def reserved_bikes(from, to)
        Models::Bike.all(
          reservations: Models::Reservation.all(
            :from.lte => to,
            :until.gte => from,
            status: 'accepted'
          )
        )
      end

      def get_by_id(reservation_id)
        reservation = Models::Reservation.get!(reservation_id)
        user = Models::User.get!(reservation.user_id)
        bike = reservation.bike
        bike_image = Models::BikeImage.first(bike_id: bike.id)
        {
          reservation: reservation,
          reservor: {
            id: user.id,
            username: user.username,
            name: user.name,
            avatar: user.image
          },
          bike: {
            name: bike.name,
            image: bike_image.image
          }
        }
      end

      def get_by_user(user)
        reservations = Models::Reservation.all(user_id: user.id)
        {
          reservations: reservations
        }
      end

      def free_bikes(from, to)
        Models::Bike.all - reserved_bikes(from, to)
      end
    end
  end
end
