# Use require with path relative to /lib
$LOAD_PATH.unshift('./lib').uniq!

require 'faker'
require 'securerandom'
require 'bikesurf/database/setup'
require 'bikesurf/database/models'
require 'bikesurf/images/image'
require 'open-uri'
require 'dotenv/load'
require 'bikesurf/config'
require 'mini_magick'

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
        puts 'Filling bikes'
        bikes = []
        10.times do
          bikes << Models::Bike.create(
            stand: stands.sample,
            name: Faker::Name.title,
            registration_number: SecureRandom.base64(12),
            description: Faker::Lorem.sentence,
            frame: Random.rand(15), crossbar: Random.rand(15),
            size: [:medium, :large, :small].sample,
            front_lights: [:yd, :yb, :n].sample,
            back_lights: [:yd, :yb, :n].sample,
            backpedal_breaking_system: [true, false].sample,
            quick_release_saddle: [true, false].sample,
            gears_number: Random.rand(10),
            min_borrow_days: Random.rand(1..3),
            max_borrow_days: Random.rand(3..6)
          )
        end
        bikes
      end

      def fill_random_comments(users)
        puts 'Filling comments'
        comments = []
        30.times do
          message = if [true, false].sample
                      Faker::Lorem.sentence
                    else
                      Faker::Lorem.paragraph
                    end

          comments << Models::Comment.create(
            user: users.sample,
            message: message,
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
          role: data[:role],
          image: data[:image]
        )
      end

      def fill_us_as_users(roles, avatars)
        puts 'Filling us'
        users = []
        users << fill_person(
          name: 'Angel Angelov', username: 'hextwoa', password: 'password',
          email: 'hextwoa@gmail.com', verified: false, role: roles.sample,
          image: avatars[0]
        )
        users << fill_person(
          name: 'Diana Geneva', username: 'dageneva', password: 'iamthewalrus',
          email: 'dageneva@gmail.com', verified: true, role: roles.sample,
          image: avatars[1]
        )
        users << fill_person(
          name: 'Zvezdalina Dimitrova', username: 'zi', password: 'passw0rd',
          email: 'zvezdi.dim@gmail.com', verified: true, role: roles.sample,
          image: avatars[2]
        )
        users << fill_person(
          name: 'Georgi Pavlov', username: 'wanker94', password: 'ilovehorde',
          email: 'georgipavlov94@gmail.com', verified: true, role: roles.sample,
          image: avatars[3]
        )
        users
      end

      def fill_random_stands(users)
        puts 'Filling stands'
        stands = []
        10.times do
          stands << Models::Stand.create(
            user: users.sample,
            location: Faker::Address.street_name
          )
        end
        stands
      end

      def fill_random_users(users, roles, avatars)
        puts 'Filling users'
        10.times do
          name = Faker::Name.name
          username = name.downcase.split(' ').first + Random.rand(200).to_s

          users << fill_person(
            name: name, username: username, password: username + ' password',
            email: name.downcase.tr(' ', '.') + '@example.com',
            verified: [true, false].sample,
            role: roles.sample,
            image: avatars.sample
          )
        end
        users
      end

      def fill_random_reservations(users, bikes)
        puts 'Filling reservations'
        reservations = []
        users.each do |user|
          3.times do
            reservations << Models::Reservation.create(
              user:         user,
              bike:         bikes.sample,
              from:         Faker::Date.between(2.days.ago, Date.today),
              until:        Faker::Date.between(Date.today, 2.days.from_now),
              pick_up_time: Faker::Time.between(2.days.ago, Time.now, :all),
              status:       [:accepted, :waiting, :declined].sample
            )
          end
        end
        reservations
      end

      def fill_random_resevation_comments(comments, reservations)
        puts 'Filling reservation comments'
        reservation_comments = []
        reservations.each do |reservation|
          5.times do
            reservation_comments << Models::ReservationComment.create(
              comment: comments.sample,
              reservation: reservation
            )
          end
        end
        reservation_comments
      end

      def fill_random_bike_comments(comments, bikes)
        puts 'Filling bike comments'
        bike_comments = []
        bikes.each do |bike|
          8.times do
            bike_comments << Models::BikeComment.create(
              comment: comments.sample,
              bike: bike
            )
          end
        end
        bike_comments
      end

      def fill_random_image(address)
        a = Time.now
        image = open(address).read
        puts(Time.now - a)
        Images.save_to_database(image)
      end

      def fill_random_avatar
        address = 'https://www.heroesofnewerth.com'\
                  "/images/heroes/#{rand(2...197)}/icon_128.jpg"
        fill_random_image(address)
      end

      def hon_avatar
        return fill_random_avatar
      rescue OpenURI::HTTPError
        return hon_avatar
      end

      def fill_random_avatars
        puts 'Filling avatars'
        avatars = []
        10.times do
          begin
            avatars << hon_avatar
          end
        end
        avatars
      end

      def fill_specific_avatars
        puts 'Filling our avatars'
        avatars = []
        # Angel
        address = 'https://www.heroesofnewerth.com/images/heroes/'\
                  '124/icon_128.jpg'
        avatars << fill_random_image(address)

        # Dodo
        address = 'https://www.heroesofnewerth.com/images/heroes/'\
                  '21/icon_128.jpg'
        avatars << fill_random_image(address)

        # Zvezdi
        address = 'https://www.heroesofnewerth.com/images/heroes/'\
                  '125/icon_128.jpg'
        avatars << fill_random_image(address)

        # Georgi
        address = 'https://www.heroesofnewerth.com/images/heroes/'\
                  '6/icon_128.jpg'
        avatars << fill_random_image(address)

        avatars
      end

      def fill_random_images
        puts 'Filling bike images'
        images = []
        10.times do
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
        puts 'Filling bike images'
        bikes.each do |bike|
          3.times do
            Models::BikeImage.create(
              image: images.sample,
              bike: bike
            )
          end
        end
      end

      def fill_dummy_data
        # delete all the images for bikes and avatars and download new
        Dir.foreach(ENV['IMAGES']) do |f|
          fn = File.join(ENV['IMAGES'], f)
          File.delete(fn) if f != '.' && f != '..'
        end

        roles = fill_roles
        images = fill_random_images
        avatars = fill_random_avatars
        specific_avatars = fill_specific_avatars
        us = fill_us_as_users(roles, specific_avatars)
        users = fill_random_users(us, roles, avatars)
        stands = fill_random_stands(users)
        bikes = fill_random_bikes(stands)
        reservations = fill_random_reservations(users, bikes)
        comments = fill_random_comments(users)
        fill_random_resevation_comments(comments, reservations)
        fill_random_bike_comments(comments, bikes)
        fill_random_bike_images(bikes, images)
      end
    end
  end
end
