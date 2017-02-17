require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class User
        include DataMapper::Resource

        property   :id,        Serial
        property   :username,  String
        property   :password,  BCryptHash
        property   :name,      String
        property   :email,     String
        property   :verified,  Boolean

        belongs_to :role
        belongs_to :image, required: false
        has n, :reservations
        has n, :comments
        has n, :sessions
      end
    end
  end
end
