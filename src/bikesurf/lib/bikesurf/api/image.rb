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

      def delete_image(image_id)
        filename = Database::ImageController.instance.delete(image_id)

        Config::IMAGE_SIZES.each do |size|
          resized_file = [filename, size.to_s].join('_')
          File.delete(File.join(ENV['IMAGES'], resized_file))
        end
        File.delete(File.join(ENV['IMAGES'], filename))
      end

      def delete_bike_image(bike_image)
        # delete the relation between bike and image
        Database::BikeImageController.instance.delete(bike_image['id'])
        # delete the image file
        # this will now lead to unexpected behavior as we have the same photo for more than one bike
        # should we delete it only when no bike has assosiation to it
        # or will each photo belong to only one bike (as expected)
        # maybe we need a default bike image which will never be deleted as well
        delete_image(bike_image['image_id'])
      end

      def delete_bike_images(bike_id)
        images = Database::BikeImageController.instance.bike_images(bike_id)
        images.each do |image|
          delete_bike_image(image)
        end
      end
    end
  end
end
