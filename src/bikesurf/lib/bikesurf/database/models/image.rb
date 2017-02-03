require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class Image
        include DataMapper::Resource

        property :id,       Serial
        property :filename, Text
      end
    end
  end
end