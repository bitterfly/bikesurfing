require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/images/image'
require 'dotenv/load'
require 'bikesurf/config'
require 'base64'

module Bikesurf
  module Requests
    module Image
      def insert_image(bike_id, base64_image)
        database_image = Images.save_to_database(Base64.decode64(base64_image))
        Database::BikeImageController.instance.add(bike_id, database_image)
      end
    end
  end
end
