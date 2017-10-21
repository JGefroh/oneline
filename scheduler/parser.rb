module Scheduler
  class Parser
    def parse(text)
      return to_data(text)
    end

    private def to_data(text)
      data = {}
      last_operator_index = text.index(' on ') || text.index(' at ') || text.index(' in ')
      data[:label] = text
      data[:time] = text
      "<X> <on|at|in> <|time-period|time|date|day>"
      return data
    end

    def identify_time(text)
      return text.scan(/([0-9]{1,2}:?[0-9]{0,2}(pm|am))/)[0][0]
    end

    def identify_date(text)
      return text.scan(/(jan|feb|mar|apr|may|june|july|aug|sep|oct|nov|dec)(\s[0-9]{1,2}(th|nd|rd|){0,1})?/)
    end
  end
end
