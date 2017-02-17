require 'digest'
require 'rubygems'
require 'dotenv/load'
require 'bikesurf/database/controllers'
require 'mini_magick'

module Bikesurf
  module Images
    def self.image_to_file(image)
      filename = Digest::SHA256.hexdigest image
      open(File.join(ENV['IMAGES'], filename), 'wb') do |file|
        file << image
      end
      filename
    end

    def self.save_to_database(image)
      filename = image_to_file(image)

      Config::IMAGE_SIZES.each do |size|
        image = MiniMagick::Image.open(
          File.join(ENV['IMAGES'], filename)
        )
        image.resize size

        new_filename = [filename, size.to_s].join('_')
        image.write File.join(ENV['IMAGES'], new_filename)
      end

      Database::ImageController.instance.create(filename)
    end
  end
end
