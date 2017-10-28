module Scheduler
  class Interpreter
    def interpret(parsed_text)
      return to_data(parsed_text)
    end

    private def to_data(parsed_text)
      interpreted_data = {}
      interpreted_data[:date] = set_date_from_day(parsed_text[:day]) if parsed_text[:day]
      interpreted_data[:date] = set_date_from_date(parsed_text[:date]) if parsed_text[:date]
      interpreted_data[:date] = set_date_from_relative_day(parsed_text[:relative_day]) if parsed_text[:relative_day]
      interpreted_data[:time] = set_time_from_relative_time(parsed_text[:relative_time]) if parsed_text[:relative_time]
      interpreted_data[:time] = set_time_from_time(parsed_text[:time]) if parsed_text[:time]
      interpreted_data[:label] = parsed_text[:label].dup if parsed_text[:label]
      interpreted_data[:command] = parsed_text[:command] || 'add'
      interpreted_data[:remove_index] = parsed_text[:remove_index].to_i if parsed_text[:remove_index]
      interpreted_data[:interpreted] = !interpreted_data[:date].nil? || !interpreted_data[:time].nil? || interpreted_data[:command] === 'remove'
      return interpreted_data
    end

    private def set_date_from_day(parsed_day)
      date_of_day = Date.parse(parsed_day)
      date_of_day += 7 if date_of_day < Date.today
      return date_of_day
    end

    private def set_date_from_date(parsed_date)
      return Date.parse(parsed_date) if parsed_date.length < 6
      return Date.strptime(parsed_date, "%m/%d/%Y") if parsed_date.length >= 6
    end

    private def set_time_from_time(parsed_time)
      return Time.parse(parsed_time)
    end

    private def set_date_from_relative_day(parsed_relative_day)
      return Date.today if parsed_relative_day === 'today'
      return (Date.today + 1) if parsed_relative_day === 'tomorrow'
    end

    private def set_time_from_relative_time(parsed_relative_time)
      time_number = parsed_relative_time.gsub(/[^0-9]+/, '').to_i
      time_unit = parsed_relative_time.gsub(/[0-9]+/, '').downcase.strip

      if ['s', 'sec', 'secs', 'second', 'seconds'].include?(time_unit)
        time_number = time_number
      end

      if ['m', 'min', 'mins', 'minute', 'minutes'].include?(time_unit)
        time_number = time_number * 60
      end

      if ['h', 'hr', 'hrs', 'hour', 'hours'].include?(time_unit)
        time_number = time_number * 60 * 60
      end

      return Time.current + time_number
    end
  end
end
