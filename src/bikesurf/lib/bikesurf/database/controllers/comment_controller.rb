require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/user'
require 'bikesurf/database/models/comment'
require 'bikesurf/database/models/reservation_comment'
require 'bikesurf/database/models/bike_comment'
require 'bikesurf/helpers/date_helper'

module Bikesurf
  module Database
    class CommentController
      include Singleton
      include ::Bikesurf::Helpers::DateHelper

      def create_comment(user_id, message)
        Models::Comment.create(
          user_id: user_id,
          message: message,
          post_time: Time.now
        )
      end

      def create_reservation_comment(user_id, reservation_id, message)
        comment_id = create_comment(user_id, message).id
        Models::ReservationComment.create(
          comment_id: comment_id,
          reservation_id: reservation_id
        )
      end

      def create_bike_comment(user_id, bike_id, message)
        comment_id = create_comment(user_id, message).id
        Models::BikeComment.create(
          comment_id: comment_id,
          bike_id: bike_id
        )
      end

      def info_from_comments(comments)
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

    end
  end
end
