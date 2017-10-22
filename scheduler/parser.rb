module Scheduler
  class Parser
    TIME_REGEX = /([0-9]{1,2}:?[0-9]{0,2}(pm|am))/
    RELATIVE_DAY_REGEX = /(today|tomorrow)/
    DAY_REGEX = /(monday|mon|tuesday|tue|wednesday|wed|thursday|thu|friday|fri|saturday|sat|sunday|sun)/i
    DATE_REGEX = /((jan|feb|mar|apr|may|june|july|aug|sep|oct|nov|dec)(\s[0-9]{1,2}(th|nd|rd|){0,1})?|[0-9]{1,2}\/[0-9]{1,2}(\/[0-9]{2,4})?)/i

    def parse(text)
      return to_data(text)
    end

    private def to_data(text)
      #<X> <on|at|in> <|time-period|time|date|day>
      data = {}
      last_operator_index = text.index(' on ') || text.index(' at ') || text.index(' in ')

      time = identify_time(text)
      store(time, data, :time)

      day = identify_day(text)
      store(day, data, :day)

      relative_day = identify_relative_day(text)
      store(relative_day, data, :relative_day)

      date = identify_date(text)
      store(date, data, :date)

      label = identify_label(text)
      data[:label] = label

      return data
    end

    def identify_time(text)
      matches = text.scan(TIME_REGEX)
      first_match_index = text.index(TIME_REGEX)
      return {time: matches[0][0], index: first_match_index} unless matches.empty?
    end

    def identify_relative_day(text)
      matches = text.scan(RELATIVE_DAY_REGEX)
      first_match_index = text.index(/(today|tomorrow)/)
      return {relative_day: matches[0][0], index: first_match_index} unless matches.empty?
    end

    def identify_day(text)
      matches = text.scan(DAY_REGEX)
      first_match_index = text.index(DAY_REGEX)
      return {day: matches[0][0], index: first_match_index} unless matches.empty?
    end

    def identify_date(text)
      matches = text.scan(DATE_REGEX)
      first_match_index = text.index(DATE_REGEX)
      return {date: matches[0][0], index: first_match_index} unless matches.empty?
    end

    def identify_label(text)
      label = text.dup

      date = identify_date(label)
      label.slice!(date[:index], date[:date].length) unless date.nil?

      relative_day = identify_relative_day(label)
      label.slice!(relative_day[:index], relative_day[:relative_day].length) unless relative_day.nil?

      time = identify_time(label)
      label.slice!(time[:index], time[:time].length) unless time.nil?

      day = identify_day(label)
      label.slice!(day[:index], day[:day].length) unless day.nil?

      return label
    end

    private def store(source, target, field)
      unless source.nil?
        target[field] = source[field]
        target["#{field}index".to_sym] = source[:index]
      end
    end
  end
end
