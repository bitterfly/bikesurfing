require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/bike'

module Bikesurf
  module Database
    class BikeController
      include Singleton
      def get_by_id(id)
        Models::Bike.get! id
      end
    end
  end
end
