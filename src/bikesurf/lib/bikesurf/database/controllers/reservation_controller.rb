require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/user'
require 'bikesurf/database/models/bike_image'
require 'bikesurf/database/models/comment'
require 'bikesurf/database/models/reservation'

module Bikesurf
  module Database
    class ReservationController
      include Singleton
      include ::Bikesurf::Helpers::DateHelper

      def reserved_bikes(from, to)
        from = from ? from : timestamp_to_date(0)
        to = to ? to : Date.new(4096, 1, 1)

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
          reservation: {
            id: reservation.id,
            from: date_to_timestamp(reservation.from),
            to: date_to_timestamp(reservation.until),
            pick_up_time: time_to_timestamp(reservation.pick_up_time),
            status: reservation.status,
          },
          reservor: {
            id: user.id,
            username: user.username,
            name: user.name,
            avatar: user.image
          },
          bike: {
            name: bike.name,
            image: bike_image.image
          },
          lender: {
            id: bike.stand.user.id,
            username: bike.stand.user.username,
            name: bike.stand.user.name,
            avatar: bike.stand.user.image
          },
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
              image: Models::BikeImage.first(
                bike_id: reservation.bike.id
              ).image,
              owner: reservation.bike.stand.user.username
            }
          }
        end
      end

      def create(from, to, user_id, bike_id)
        Models::Reservation.create(
          from: from,
          until: to,
          user_id: user_id,
          bike_id: bike_id,
          status: 'waiting'
        )
      end

      def get_comments_by_id(id)
        comments = Models::Comment.all(
          reservation_comment: Models::ReservationComment.all(reservation_id: id)
        )

        CommentController.instance.info_from_comments comments
      end

      def free_bikes(from, to)
        Models::Bike.all - reserved_bikes(from, to)
      end
    end
  end
end
