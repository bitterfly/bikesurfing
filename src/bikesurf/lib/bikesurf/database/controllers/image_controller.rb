require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/image'

module Bikesurf
  module Database
    class ImageController
      include Singleton

      def create(filename)
        Models::Image.create(
          filename: filename
        )
      end

      def delete(id)
        image = Models::Image.get(id)
        filename = image.filename
        image.destroy
        filename
      end
    end
  end
end
