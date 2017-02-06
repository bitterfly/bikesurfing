require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/images/image'
require 'dotenv/load'
require 'bikesurf/config'
require 'mini_magick'



module Bikesurf
  module Requests
    module Image
      def insert_image(bike, image)
        database_image = Images.save_to_database(image)

        Config::IMAGE_SIZES.each do |size|
          image = MiniMagick::Image.open(
            File.join(ENV['IMAGES'], database_image.filename)
          )
          image.resize size

          new_filename = [database_image.filename, size.to_s].join('_')
          image.write File.join(ENV['IMAGES'], new_filename)

          Database::BikeImageController.instance.add(bike, database_image)
        end
      end
    end
  end
end
