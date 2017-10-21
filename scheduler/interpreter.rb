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
      interpreted_data[:date] = set_date_from_date(parsed_text[:date]) if parsed_text[:date]
      interpreted_data[:relative_day] = set_date_from_relative_day(parsed_text[:relative_day]) if parsed_text[:relative_day]
      interpreted_data[:time] = set_time_from_time(parsed_text[:time]) if parsed_text[:time]
      interpreted_data[:interpreted] = true unless interpreted_data.empty?
      return interpreted_data
    end

    def set_date_from_day(parsed_day)
      date_of_day = Date.parse(parsed_day)
      date_of_day += 7 if date_of_day < Date.today
      return date_of_day
    end

    def set_date_from_date(parsed_date)
      return Date.parse(parsed_date) if parsed_date.length < 6
      return Date.strptime(parsed_date, "%m/%d/%Y") if parsed_date.length >= 6
    end

    def set_time_from_time(parsed_time)
      return Time.parse(parsed_time)
    end

    def set_date_from_relative_day(parsed_relative_day)
      return Date.today if parsed_relative_day === 'today'
      return (Date.today + 1) if parsed_relative_day === 'tomorrow'
    end
  end
end
