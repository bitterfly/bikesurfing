require 'rubygems'
require 'data_mapper'

module Bikesurf
  module Database
    module Models
      class Role
        include DataMapper::Resource
        property :id,         Serial
        property :name,       String

        has n, :users
        has n, :role_permissions
        has n, :permissions, through: :role_permissions
      end
    end
  end
end