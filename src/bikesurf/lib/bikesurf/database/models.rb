require 'rubygems'
require 'data_mapper'
require 'dotenv/load'

module Bikesurf
	module Database
    DataMapper.setup(:default, ENV["DATABASE_URN"])

    class Bike
      include DataMapper::Resource

      property :id,                        Serial
      property :registration_number,       String
      property :name,                      String
      property :desctiption,               Text
      property :frame,                     Integer
      property :crossbar,                  Integer
      property :front_lights,              String
      property :back_lights,               String
      property :backpedal_breaking_system, Boolean
      property :quick_release_saddle,      Boolean
      property :gears_number,              Integer
    end

    class User
      include DataMapper::Resource

      property   :id,       Serial
      property   :username, String
      property   :password, BCryptHash
      property   :name,     String
      property   :email,    String
      property   :verified,  Boolean
     
      belongs_to :role
    end

    class Role
      include DataMapper::Resource
      property :id,         Serial
      property :name,       String

      has n, :users
      has n, :role_permissions
      has n, :permissions,  :through => :role_permissions
    end

    class Permission
      include DataMapper::Resource
      property :id,     Serial
      property :name,   String

      has n, :role_permissions
      has n, :roles,    :through => :role_permissions
    end

    class RolePermission
      include DataMapper::Resource

      property :id,         Serial

      belongs_to :role
      belongs_to :permission
    end

    DataMapper.finalize
  end
end