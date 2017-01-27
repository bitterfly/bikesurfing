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
      property :size,                      String
      property :front_lights,              String
      property :back_lights,               String
      property :backpedal_breaking_system, Boolean
      property :quick_release_saddle,      Boolean
      property :gears_number,              Integer
      property :min_borrow_days,           Integer
      property :max_borrow_days,           Integer

      belongs_to :stand
      has n, :reservations
    end

    class User
      include DataMapper::Resource

      property   :id,        Serial
      property   :username,  String
      property   :password,  BCryptHash
      property   :name,      String
      property   :email,     String
      property   :verified,  Boolean
     
      belongs_to :role
      has n, :reservations
    end

    class Stand
      include DataMapper::Resource

      property :id,       Serial
      property :location, String

      belongs_to :user
    end

    class Reservation
      include DataMapper::Resource

      property :id,            Serial
      property :until,         Date
      property :from,          Date
      property :pick_up_time,  DateTime

      belongs_to :bike
      belongs_to :user
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