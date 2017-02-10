require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class Session
        include DataMapper::Resource

        property :id,         Serial
        property :session_id, String, length: 256
        property :create_time, DateTime
        belongs_to :user
      end
    end
  end
end
