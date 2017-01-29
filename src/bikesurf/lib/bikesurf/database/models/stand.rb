require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class Stand
        include DataMapper::Resource

        property :id,       Serial
        property :location, String

        belongs_to :user
      end
    end
  end
end   