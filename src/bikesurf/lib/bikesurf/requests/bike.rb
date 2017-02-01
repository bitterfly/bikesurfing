require 'bikesurf/database/controllers'

module Bikesurf
  module Requests
    module Bike

      def find_bike(data)
        BikeController.instance.get_by_id data
      end
    end
  end
end
