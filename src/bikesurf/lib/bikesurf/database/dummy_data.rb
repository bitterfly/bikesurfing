# Use require with path relative to /lib
$LOAD_PATH.unshift('./lib').uniq!

require 'faker'
require 'securerandom'
require 'bikesurf/database/setup'
require 'bikesurf/database/models'
require 'bikesurf/images/image'
require 'open-uri'
require 'dotenv/load'

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
          bikes << Models::Bike.create(
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

      def fill_random_comments(users)
        comments = []
        20.times do
          comments << Models::Comment.create(
            user: users.sample,
            message: Faker::Lorem.sentence,
            post_time: Time.now
          )
        end
        comments
      end
        

      def fill_roles
        roles = []
        roles << Models::Role.create(
          name: 'user'
        )

        roles << Models::Role.create(
          name: 'admin'
        )

        roles << Models::Role.create(
          name: 'owner'
        )
        roles
      end

      def fill_person(data)
        Models::User.create(
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
          stands << Models::Stand.create(
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
          reservations << Models::Reservation.create(
            user:         users.sample,
            bike:         bikes.sample,
            from:         Faker::Date.between(2.days.ago, Date.today),
            until:        Faker::Date.between(Date.today, 2.days.from_now),
            pick_up_time: Faker::Time.between(2.days.ago, Time.now, :all)
          )
        end
        reservations
      end

      def fill_random_resevation_comments(comments, reservations)
        reservation_comments = []
        10.times do
          reservation_comments << Models::ReservationComment.create(
            comment: comments.sample(),
            reservation: reservations.sample()  
          )
        end
        reservation_comments      
      end


      def fill_random_bike_comments(comments, bikes)
        bike_comments = []
        10.times do
          bike_comments << Models::BikeComment.create(
            comment: comments.sample(),
            bike: bikes.sample()  
          )
        end
        bike_comments      
      end

      def fill_random_image
        a = Time.now
        image = open('https://unsplash.it/900/600?random').read
        puts(Time.now - a)
        Images::save_to_database(image)
      end

      def fill_random_images
        Dir.foreach(ENV['IMAGES']) do |f| 
          fn = File.join(ENV['IMAGES'], f)
          File.delete(fn) if f != '.' && f != '..'
        end
        images = []
        10.times do
          images << fill_random_image
          begin
            width = rand(600) + 900
            height = rand(300) + 600
            address = "http://lorempixel.com/#{width}/#{height}"
            images << fill_random_image(address)
          rescue OpenURI::HTTPError
            images << nil
          end
        end
        images
      end

      def fill_random_bike_images(bikes, images)
        bikes.each do |bike|
          3.times do
            Models::BikeImage.create(
              image: images.sample(),
              bike: bike  
            )
          end
        end
      end

      def fill_dummy_data
        roles = fill_roles
        us = fill_us_as_users(roles)
        users = fill_random_users(us, roles)
        stands = fill_random_stands(users)
        bikes = fill_random_bikes(stands)
        reservations = fill_random_reservations(users, bikes)
        comments = fill_random_comments(users)
        fill_random_resevation_comments(comments, reservations)
        fill_random_bike_comments(comments, bikes)
        images = fill_random_images
        fill_random_bike_images(bikes, images)
      end
    end
  end
end
