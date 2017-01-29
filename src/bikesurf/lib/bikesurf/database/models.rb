require 'rubygems'
require 'data_mapper'
require 'dotenv/load'

module Bikesurf
  module Database
    DataMapper.setup(:default, ENV['DATABASE_URN'])
  end
end

require 'bikesurf/database/models/bike'
require 'bikesurf/database/models/permission'
require 'bikesurf/database/models/reservation'
require 'bikesurf/database/models/role'
require 'bikesurf/database/models/role_permission'
require 'bikesurf/database/models/stand'
require 'bikesurf/database/models/user'


module Bikesurf
  module Database
    DataMapper.finalize
  end
end
