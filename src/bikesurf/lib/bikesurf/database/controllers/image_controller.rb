require 'rubygems'
require 'singleton'
require 'bikesurf/database/models/image'

module Bikesurf
  module Database
    class ImageController
      include Singleton
      def add(filename)
          Models::Image.create(
            filename: filename
          )
      end
    end
  end
end
