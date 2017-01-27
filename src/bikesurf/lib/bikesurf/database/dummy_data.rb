# Use require with path relative to /lib
$:.unshift("./lib").uniq!

require 'bikesurf/database/models'
require 'namey'
require 'securerandom'

module Bikesurf
	module Database
    def self.fill_dummy_data()
  	  r1 = Bikesurf::Database::Role.create(
        name: "user"
      )

      r2 = Bikesurf::Database::Role.create(
        name: "admin"
      )
      
      r3 = Bikesurf::Database::Role.create(
        name: "owner"
      )

      u1 = Bikesurf::Database::User.create(
        name: "Angel Angelov",
        username: "hextwoa",
        password: "password",
        email:"hextwoa@gmail.com",
        verified: false,
        role: r1,
      )

      u2 = Bikesurf::Database::User.create(
        name: "Diana Geneva",
        username: "dageneva",
        password: "iamthewalrus",
        email:"dageneva@gmail.com",
        verified: true,
        role: r1,
      )

      u3 = Bikesurf::Database::User.create(
        name: "Zvezdalina Dimitrova",
        username: "zi",
        password: "passw0rd",
        email:"zvezdi.dim@gmail.com",
        verified: true,
        role: r2,
      )

      u4 = owner = Bikesurf::Database::User.create(
        name: "Georgi Pavlov",
        username: "gogopal",
        password: "iamhorde",
        email: "georgi@not.real",
        verified: true,
        role: r3,
      )

      10.times do 
        n = Namey::Generator.new.name
        uname = n.downcase.gsub(/ .*/, '') + Random.rand(200).to_s

        Bikesurf::Database::User.create(
          name: n,
          username: uname,
          password: uname + " password",
          email: n.downcase.gsub(/ /, '.') + '@example.com',
          verified: [true, false].sample,
          role: r1,
        )
      end

      stands = []
      10.times do
        stands << Bikesurf::Database::Stand.create(
          user: [u1,u2, u3, u4].sample,
          location: "Some Place",
        )
      end

      10.times do 
        Bikesurf::Database::Bike.create(
          stand: stands.sample,
          registration_number: SecureRandom.base64(12) ,
          desctiption: "lorem ipsum",
          name: Namey::Generator.new.name,
          frame: Random.rand(15),
          crossbar: Random.rand(15) ,
          size: [:medium, :large, :small].sample,
          front_lights: [:yd, :yb, :n].sample,
          back_lights: [:yd, :yb, :n].sample,
          backpedal_breaking_system: [true, false].sample,
          quick_release_saddle: [true, false].sample,
          gears_number: Random.rand(10),
          min_borrow_days: Random.rand(6) + 1,
          max_borrow_days: Random.rand(6) + 1,
        )
      end
    end
	end
end