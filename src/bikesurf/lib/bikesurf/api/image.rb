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

      def delete_image(bike_id, image_id)
        filename = Database::ImageController.instance.delete(image_id)

        Config::IMAGE_SIZES.each do |size|
            resized_file = [filename, size.to_s].join('_')
            File.delete(File.join(ENV['IMAGES'], resized_file))
        end
        File.delete(File.join(ENV['IMAGES'], filename))
      end
    end
  end
end
