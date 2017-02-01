require 'rubygems'
require 'data_mapper'
require 'dotenv/load'

module Bikesurf
  module Database
    DataMapper.setup(:default, ENV['DATABASE_URN'])
  end
end

require 'bikesurf/database/models'

module Bikesurf
  module Database
    DataMapper.finalize
  end
end
