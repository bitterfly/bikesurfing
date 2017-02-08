require 'rubygems'
require 'bikesurf/database/controllers'

module Bikesurf
  module Requests
    module Session
      def login(username, password)
        user = Database::UserController.instance.check_user(username, password)
        {
          username: user.username,
          name: user.name,
          avatar: user.image.filename,
          session_id: Database::SessionController.instance.make_session(user.id)
        }
      end

      def logout(session_id)
        Database::SessionController.instance.delete(session_id)
        {}
      end

      def get_user_by_session(session_id)
        Database::SessionController.instance.get_user(session_id)
      end
    end
  end
end
