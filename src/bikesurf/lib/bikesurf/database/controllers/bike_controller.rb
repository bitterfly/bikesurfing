require 'singleton'

module Bikesurf
  module Database
    class BikeController
      include Singleton
      def get_by_id(id)
        42
      end
    end
  end
end