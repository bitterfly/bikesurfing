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
      include ::Bikesurf::Helpers::DateHelper

      def reserved_bikes(from, to)
        raise 'Please, select a valid period.' unless valid_period?(from, to)

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
        reservations.map do |reservation|
          {
            reservation: {
              id: reservation.id,
              from: date_to_timestamp(reservation.from),
              to: date_to_timestamp(reservation.until),
              status: reservation.status
            },
            bike: {
              name: reservation.bike.name,
              image: Models::BikeImage.first(bike_id: reservation.bike.id).image,
              owner: reservation.bike.stand.user.username
            }
          }
        end
      end

      def free_bikes(from, to)
        borrow_duration = day_difference(from, to)
        bikes_for_duration = Models::Bike.all(
          :min_borrow_days.lte => borrow_duration,
          :max_borrow_days.gte => borrow_duration
        )

        bikes_for_duration - reserved_bikes(from, to)
      end
    end
  end
end
