module Scheduler
  class Parser
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

      return data
    end

    def identify_time(text)
      matches = text.scan(/([0-9]{1,2}:?[0-9]{0,2}(pm|am))/)
      first_match_index = text.index(/([0-9]{1,2}:?[0-9]{0,2}(pm|am))/)
      return {time: matches[0][0], index: first_match_index} unless matches.empty?
    end

    def identify_relative_day(text)
      matches = text.scan(/(today|tomorrow)/)
      first_match_index = text.index(/(today|tomorrow)/)
      return {relative_day: matches[0][0], index: first_match_index} unless matches.empty?
    end

    def identify_day(text)
      matches = text.scan(/(monday|mon|tuesday|tue|wednesday|wed|thursday|thu|friday|fri|saturday|sat|sunday|sun)/i)
      first_match_index = text.index(/(monday|mon|tuesday|tue|wednesday|wed|thursday|thu|friday|fri|saturday|sat|sunday|sun)/i)
      return {day: matches[0][0], index: first_match_index} unless matches.empty?
    end

    def identify_date(text)
      matches = text.scan(/((jan|feb|mar|apr|may|june|july|aug|sep|oct|nov|dec)(\s[0-9]{1,2}(th|nd|rd|){0,1})?|[0-9]{1,2}\/[0-9]{1,2}(\/[0-9]{2,4})?)/i)
      first_match_index = text.index(/((jan|feb|mar|apr|may|june|july|aug|sep|oct|nov|dec)(\s[0-9]{1,2}(th|nd|rd|){0,1})?|[0-9]{1,2}\/[0-9]{1,2}(\/[0-9]{2,4})?)/i)
      return {date: matches[0][0], index: first_match_index} unless matches.empty?
    end

    private def store(source, target, field)
      unless source.nil?
        target[field] = source[field]
        target["#{field}index".to_sym] = source[:index]
      end
    end
  end
end
