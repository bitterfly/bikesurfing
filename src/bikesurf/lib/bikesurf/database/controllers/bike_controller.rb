require "Bikesurf/database/models"

module Bikesurf
  module Database
    class BikeController
      include Singleton
      def get_by_id(id):
        Bike.get!(id)
    end
  end
end