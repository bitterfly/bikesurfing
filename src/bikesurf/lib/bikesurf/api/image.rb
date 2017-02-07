require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/images/image'
require 'dotenv/load'
require 'bikesurf/config'

module Bikesurf
  module Requests
    module Image
      def insert_image(bike_id, image)
        database_image = Images.save_to_database(image)
        Database::BikeImageController.instance.add(bike_id, database_image)
      end
    end
  end
end
