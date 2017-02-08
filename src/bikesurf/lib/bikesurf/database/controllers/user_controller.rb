require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/user'

module Bikesurf
  module Database
    class UserController
      include Singleton

      def check_user(username, password)
        user = Models::User.first(
          username: username,
        )
        raise "wrong username" unless user
        raise "wrong password" unless user.password == password
        user
      end
    end
  end
end
