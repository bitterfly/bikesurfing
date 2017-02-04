require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class Comment
        include DataMapper::Resource

        property :id,                        Serial
        property :message,                   Text
        property :post_time,                 DateTime

        belongs_to :user

        has 1, :reservation_comment
        has 1, :bike_comment
      end
    end
  end
end
