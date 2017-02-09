require 'date'

module Bikesurf
  module Helpers
    module DateHelper
      def timestamp_to_date(timestamp)
        Time.at(timestamp).utc.to_datetime.to_date
      end

      def date_to_timestamp(date)
        Time.utc(date.year, date.month, date.day).to_i
      end

      def timestamp_to_time(timestamp)
        Time.at(timestamp).utc
      end

      def time_to_timestamp(time)
        time.to_i
      end

      def valid_period?(from, to)
        from <= to
      end

      def day_difference(from, to)
        # smarter implementation needed
        seconds_in_a_day = 60 * 60 * 24
        (to - from) / seconds_in_a_day
      end
    end
  end
end
