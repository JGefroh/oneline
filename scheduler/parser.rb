module Scheduler
  class Parser
    def parse(text)
      return to_data(text)
    end

    private def to_data(text)
      #<X> <on|at|in> <|time-period|time|date|day>
      data = {}
      last_operator_index = text.index(' on ') || text.index(' at ') || text.index(' in ')
      data[:time] = identify_time(text)
      data[:day] = identify_day(text)
      data[:date] = identify_date(text)
      data[:relative_day] = identify_relative_day(text)
      return data
    end

    def identify_time(text)
      matches = text.scan(/([0-9]{1,2}:?[0-9]{0,2}(pm|am))/)
      return matches[0][0] unless matches.empty?
    end

    def identify_relative_day(text)
      matches = text.scan(/(today|tomorrow)/)
      return matches[0][0] unless matches.empty?
    end

    def identify_day(text)
      matches = text.scan(/(monday|mon|tuesday|tue|wednesday|wed|thursday|thu|friday|fri|saturday|sat|sunday|sun)/i)
      return matches[0][0] unless matches.empty?
    end

    def identify_date(text)
      matches = text.scan(/((jan|feb|mar|apr|may|june|july|aug|sep|oct|nov|dec)(\s[0-9]{1,2}(th|nd|rd|){0,1})?|[0-9]{1,2}\/[0-9]{1,2}(\/[0-9]{2,4})?)/i)
      return matches[0][0] unless matches.empty?
    end
  end
end
