require 'rubygems'
require 'bikesurf/database/controllers'

module Bikesurf
  module Requests
    module Session
      def login(username, password)
        user = Database::UserController.instance.check_user(username, password)
        {
          session_id: Database::SessionController.instance.make_session(user.id)
        }
      end
    end
  end
end
