require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database 
    module Models
      class Permission
        include DataMapper::Resource
        property :id,     Serial
        property :name,   String

        has n, :role_permissions
        has n, :roles, through: :role_permissions
      end
    end
  end
end
