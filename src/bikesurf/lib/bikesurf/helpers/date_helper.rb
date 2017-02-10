require 'date'

module Bikesurf
  module Helpers
    module DateHelper
      def timestamp_to_date(timestamp)
        nil unless timestamp
        Time.at(timestamp).utc.to_datetime.to_date
      end

      def date_to_timestamp(date)
        nil unless date
        Time.utc(date.year, date.month, date.day).to_i
      end

      def timestamp_to_time(timestamp)
        nil unless timestamp
        Time.at(timestamp).utc
      end

      def time_to_timestamp(time)
        nil unless time
        time.to_time.to_i
      end

      def valid_period?(from, to)
        from <= to
      end

      def day_difference(from, to)
        # smarter implementation needed
        (to - from).to_i + 1
      end
    end
  end
end
