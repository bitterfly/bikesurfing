# Use require with path relative to /lib
$:.unshift("./lib").uniq!

require 'bikesurf/database/models'
require 'faker'
require 'securerandom'

class Fixnum
  SECONDS_IN_DAY = 24 * 60 * 60

  def days
    self * SECONDS_IN_DAY
  end

  def ago
    Time.now - self
  end

  def from_now
    Time.now + self
  end
end


module Bikesurf
	module Database
    def self.fill_dummy_data()
  	  roles = []
      roles << Bikesurf::Database::Role.create(
        name: "user"
      )

      roles << Bikesurf::Database::Role.create(
        name: "admin"
      )
      
      roles << Bikesurf::Database::Role.create(
        name: "owner"
      )

      users = []
      users << Bikesurf::Database::User.create(
        name: "Angel Angelov",
        username: "hextwoa",
        password: "password",
        email:"hextwoa@gmail.com",
        verified: false,
        role: roles.sample,
      )

      users << Bikesurf::Database::User.create(
        name: "Diana Geneva",
        username: "dageneva",
        password: "iamthewalrus",
        email:"dageneva@gmail.com",
        verified: true,
        role: roles.sample,
      )

      users << Bikesurf::Database::User.create(
        name: "Zvezdalina Dimitrova",
        username: "zi",
        password: "passw0rd",
        email:"zvezdi.dim@gmail.com",
        verified: true,
        role: roles.sample,
      )

      users << owner = Bikesurf::Database::User.create(
        name: "Georgi Pavlov",
        username: "gogopal",
        password: "iamhorde",
        email: "georgi@not.real",
        verified: true,
        role: roles.sample,
      )

      10.times do 
        n = Faker::Name.name
        uname = n.downcase.gsub(/ .*/, '') + Random.rand(200).to_s

        users << Bikesurf::Database::User.create(
          name: n,
          username: uname,
          password: uname + " password",
          email: n.downcase.gsub(/ /, '.') + '@example.com',
          verified: [true, false].sample,
          role: roles.sample,
        )
      end

      stands = []
      10.times do
        stands << Bikesurf::Database::Stand.create(
          user: users.sample,
          location: Faker::Address.street_name,
        )
      end

      bikes = []
      10.times do
        bikes << Bikesurf::Database::Bike.create(
          stand: stands.sample,
          name: Faker::Name.title,
          registration_number: SecureRandom.base64(12) ,
          desctiption: Faker::Lorem.sentence,
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

      10.times do
        Bikesurf::Database::Reservation.create(
          user:         users.sample,
          bike:         bikes.sample,
          from:         Faker::Date.between(2.days.ago, Date.today),
          until:        Faker::Date.between(Date.today, 2.days.from_now) ,
          pick_up_time: Faker::Time.between(2.days.ago, Time.now, :all),
        )
      end
    end
	end
end