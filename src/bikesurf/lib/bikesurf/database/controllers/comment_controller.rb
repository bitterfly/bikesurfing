require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/user'
require 'bikesurf/database/models/comment'
require 'bikesurf/database/models/reservation_comment'

module Bikesurf
  module Database
    class CommentController
      include Singleton

      def create_comment(user_id, message)
        comment = Models::Comment.create(
          user_id: user_id,
          message: message,
          post_time: Time.now
        )
      end

      def create_reservation_comment(user_id, reservation_id, message)
        comment_id = create_comment(user_id, message).id
        reservation = Models::ReservationComment.create(
          comment_id: comment_id,
          reservation_id: reservation_id
        )
      end
    end
  end
end
