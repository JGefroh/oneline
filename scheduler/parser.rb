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
      data = {}
      [:date, :day, :label, :relative_day, :time].each{ |field| identify_and_store(field, data, text) }
      return data
    end

    private def identify_and_store(field, data, text)
      if field === :label
        label = identify_label(text)
        data[:label] = label
      else
        identified_field = send(:identify_field, field, text)
        store(identified_field, data, field)
      end
    end

    private def identify_field(field, text)
      regex = self.class.const_get("#{field.to_s.upcase}_REGEX")
      matches = text.scan(regex)
      first_match_index = text.index(regex)
      return {"#{field}": matches[0][0], index: first_match_index} unless matches.empty?
    end

    private def identify_label(text)
      label = text.dup

      date = identify_field(:date, label)
      date_article_offset = [' on ', ' at '].include?(label[date[:index] - 4, 4]) ? 4 : 0 unless date.nil?
      label.slice!(date[:index] - date_article_offset, date[:date].length + date_article_offset) unless date.nil?

      relative_day = identify_field(:relative_day, label)
      relative_day_article_offset = label[relative_day[:index] - 4, 4] === ' on ' ? 4 : 0 unless relative_day.nil?
      label.slice!(relative_day[:index] - relative_day_article_offset, relative_day[:relative_day].length + relative_day_article_offset) unless relative_day.nil?

      time = identify_field(:time, label)
      time_article_offset = label[time[:index] - 4, 4] === ' at ' ? 4 : 0 unless time.nil?
      label.slice!(time[:index] - time_article_offset, time[:time].length + time_article_offset) unless time.nil?

      day = identify_field(:day, label)
      day_article_offset = label[day[:index] - 4, 4] === ' on ' ? 4 : 0 unless day.nil?
      label.slice!(day[:index] - day_article_offset, day[:day].length + day_article_offset) unless day.nil?

      return label.strip
    end

    private def store(source, target, field)
      target[field] = source[field] unless source.nil?
    end
  end
end
