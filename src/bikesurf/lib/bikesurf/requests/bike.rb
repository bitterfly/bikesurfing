require 'bikesurf/database/controllers'

module Bikesurf
  module Requests
    module Bike
      @bike_controller = BikeController.instance

      def find_bike(data)
        @bike_controller.get_by_id data
      end
    end
  end
end
