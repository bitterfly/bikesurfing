# Use require with path relative to /lib
$LOAD_PATH.unshift('./lib').uniq!

require 'bikesurf/database/models'
require 'faker'
require 'securerandom'

class Integer
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
    class DummyData
      def fill_random_bikes(stands)
        bikes = []
        10.times do
          bikes << Bikesurf::Database::Models::Bike.create(
            stand: stands.sample,
            name: Faker::Name.title,
            registration_number: SecureRandom.base64(12),
            desctiption: Faker::Lorem.sentence,
            frame: Random.rand(15),
            crossbar: Random.rand(15),
            size: [:medium, :large, :small].sample,
            front_lights: [:yd, :yb, :n].sample,
            back_lights: [:yd, :yb, :n].sample,
            backpedal_breaking_system: [true, false].sample,
            quick_release_saddle: [true, false].sample,
            gears_number: Random.rand(10),
            min_borrow_days: Random.rand(6) + 1,
            max_borrow_days: Random.rand(6) + 1
          )
        end
        bikes
      end

      def fill_roles
        roles = []
        roles << Bikesurf::Database::Models::Role.create(
          name: 'user'
        )

        roles << Bikesurf::Database::Models::Role.create(
          name: 'admin'
        )

        roles << Bikesurf::Database::Models::Role.create(
          name: 'owner'
        )
        roles
      end

      def fill_person(data)
        Bikesurf::Database::Models::User.create(
          name: data[:name],
          username: data[:username],
          password: data[:password],
          email: data[:email],
          verified: data[:verified],
          role: data[:role]
        )
      end

      def fill_us_as_users(roles)
        users = []
        users << fill_person(
          name: 'Angel Angelov', username: 'hextwoa', password: 'password',
          email: 'hextwoa@gmail.com', verified: false, role: roles.sample
        )
        users << fill_person(
          name: 'Diana Geneva', username: 'dageneva', password: 'iamthewalrus',
          email: 'dageneva@gmail.com', verified: true, role: roles.sample
        )
        users << fill_person(
          name: 'Zvezdalina Dimitrova', username: 'zi', password: 'passw0rd',
          email: 'zvezdi.dim@gmail.com', verified: true, role: roles.sample
        )
        users << fill_person(
          name: 'Georgi Pavlov', username: 'wanker94', password: 'ilovehorde',
          email: 'georgipavlov94@gmail.com', verified: true, role: roles.sample
        )
        users
      end

      def fill_random_stands(users)
        stands = []
        10.times do
          stands << Bikesurf::Database::Models::Stand.create(
            user: users.sample,
            location: Faker::Address.street_name
          )
        end
        stands
      end

      def fill_random_users(users, roles)
        10.times do
          name = Faker::Name.name
          username = name.downcase.split(' ').first + Random.rand(200).to_s

          users << fill_person(
            name: name, username: username, password: username + ' password',
            email: name.downcase.tr(' ', '.') + '@example.com',
            verified: [true, false].sample,
            role: roles.sample
          )
        end
        users
      end

      def fill_random_reservations(users, bikes)
        reservations = []
        10.times do
          reservations = Bikesurf::Database::Models::Reservation.create(
            user:         users.sample,
            bike:         bikes.sample,
            from:         Faker::Date.between(2.days.ago, Date.today),
            until:        Faker::Date.between(Date.today, 2.days.from_now),
            pick_up_time: Faker::Time.between(2.days.ago, Time.now, :all)
          )
        end
        reservations
      end

      def fill_dummy_data
        roles = fill_roles
        us = fill_us_as_users(roles)
        users = fill_random_users(us, roles)
        stands = fill_random_stands(users)
        bikes = fill_random_bikes(stands)
        fill_random_reservations(users, bikes)
      end
    end
  end
end
