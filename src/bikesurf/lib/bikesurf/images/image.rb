require 'digest'
require 'rubygems'
require 'dotenv/load'
require 'bikesurf/database/controllers'

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
      Database::ImageController.instance.add(filename)
    end
  end
end
