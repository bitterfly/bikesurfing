require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/user'
require 'bikesurf/database/models/comment'
require 'bikesurf/database/models/reservation_comment'

module Bikesurf
  module Database
    class CommentController
      include Singleton

      def create_comment(message)

        property :id,                        Serial
        property :message,                   Text
        property :post_time,                 DateTime

        comment = Models::Comment.create(
          message: message,
          post_time: Time.now
        )
      end

      def create_reservation_comment(reservation_id, message)
        comment_id = create_comment(message).id
        Models::ReservationComment.create(
          comment_id: comment_id,
          reservation_id: reservation_id
        )
      end
    end
  end
end
