require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/user'
require 'securerandom'

module Bikesurf
  module Database
    class SessionController
      include Singleton

      def make_session(user_id)
        session_id = SecureRandom.hex(128)
        Models::Session.create(
          user_id: user_id,
          session_id: session_id,
          create_time: Time.now
        )
        session_id
      end

      def delete(session_id)
        session = Models::Session.first(session_id: session_id)
        session.destroy
      end

      def get_user(session_id)
        session = Models::Session.first(session_id: session_id)
        return nil unless session
        session.user
      end
    end
  end
end
