require 'rubygems'
require 'bikesurf/database/controllers'
require 'bikesurf/helpers/date_helper'

module Bikesurf
  module Requests
    module Search
      include ::Bikesurf::Helpers::DateHelper

      def fitting_criteria_bikes(criteria)
        from_sql_datetime = timestamp_to_date(criteria['from'])
        to_sql_datetime = timestamp_to_date(criteria['to'])

        errors = []
        errors << 'Please select time period.' unless from_sql_datetime && to_sql_datetime
        errors << 'Please select a valid time period.' unless valid_period?(from_sql_datetime, to_sql_datetime)
        return { errors: errors } unless errors.empty?

        transform criteria

        Database::ReservationController
          .instance
          .free_fitting_criteria_bikes(from_sql_datetime, to_sql_datetime, criteria)
      end

      def transform(criteria)
        criteria.delete_if { |key, value| value.to_s.strip.empty? || key == 'from' || key == 'to' }
        criteria.map { |key, value| [key.to_sym, value] }.to_h
      end
    end
  end
end
