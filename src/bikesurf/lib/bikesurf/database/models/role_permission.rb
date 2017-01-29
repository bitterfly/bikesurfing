require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models  
      class RolePermission
        include DataMapper::Resource

        property :id, Serial

        belongs_to :role
        belongs_to :permission
      end
    end
  end
end