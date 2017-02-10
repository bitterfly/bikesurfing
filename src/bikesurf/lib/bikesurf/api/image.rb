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
        Database::BikeImageController.instance.create(bike_id, database_image)
      end

      def delete_image_files(filename)
        Config::IMAGE_SIZES.each do |size|
          resized_file = [filename, size.to_s].join('_')
          File.delete(File.join(ENV['IMAGES'], resized_file))
        end
        File.delete(File.join(ENV['IMAGES'], filename))
      end

      def delete_image(image)
        filename = Database::ImageController.instance.delete(image['id'])
        delete_image_files(filename)
      end

      def delete_bike_images(bike_id)
        images = Database::BikeImageController.instance.bike_images(bike_id)
        images.each do |image|
          delete_image(image)
        end
      end
    end
  end
end
