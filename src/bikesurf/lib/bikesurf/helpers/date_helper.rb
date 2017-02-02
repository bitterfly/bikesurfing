require 'date'

module DateHelper
  def date_of(timestamp)
    Time.at(timestamp).utc.to_date
  end

  def timestamp_of(date)
    date.to_time.utc.to_i
  end
end
