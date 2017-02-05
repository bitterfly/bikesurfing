require 'date'

module Bikesurf
  module Helpes
    module DateHelper
      def self.timestamp_to_date(timestamp)
        Time.at(timestamp).utc.to_datetime.to_date
      end

      def self.date_to_timestamp(date)
        Time.utc(date.year, date.month, date.day).to_i
      end

      def self.timestamp_to_time(timestamp)
        Time.at(timestamp).utc
      end

      def self.time_to_timestamp(time)
        time.to_i
      end
    end
  end
end
