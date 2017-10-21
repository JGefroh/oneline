require 'date'
require 'time'

module Scheduler
  class Interpreter
    def interpret(parsed_text)
      return to_data(parsed_text)
    end

    private def to_data(parsed_text)
      interpreted_data = {}
      interpreted_data[:date] = set_date_from_day(parsed_text[:day]) if parsed_text[:day]
      interpreted_data[:date] = set_date_from_day(parsed_text[:date]) if parsed_text[:date]
      interpreted_data[:time] = set_time_from_time(parsed_text[:time]) if parsed_text[:time]
      return interpreted_data
    end

    def set_date_from_day(parsed_day)
      date_of_day = Date.parse(parsed_day)
      date_of_day += 7 if date_of_day < Date.today
      return date_of_day
    end

    def set_date_from_date(parsed_date)
      return Date.parse(parsed_day)
    end

    def set_time_from_time(parsed_time)
      return Time.parse(parsed_time)
    end
  end
end
