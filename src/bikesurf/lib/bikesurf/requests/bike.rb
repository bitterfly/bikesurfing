require 'rubygems'
require 'bikesurf/database/controllers'

module Bikesurf
  module Requests
    module Bike
      def find_bike(data)
        Database::BikeController.instance.get_by_id data
      end
    end
  end
end
