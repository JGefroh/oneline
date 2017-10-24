require "test/unit"
require_relative '../parser'
module Scheduler
  class ParserTest < Test::Unit::TestCase
    def self.startup
      @@parser = Scheduler::Parser.new
    end

    def test_junk_text
      data = @@parser.parse("junk text")
      assert_equal('junk text', data[:label])
    end


    def test_label_at
      data = @@parser.parse("meeting at 12pm")
      assert_equal('meeting', data[:label])
    end


    def test_parse_time
      data = @@parser.parse("Go to the store at 12pm")
      assert_equal("12pm", data[:time])
    end

    def test_parse_day
      data = @@parser.parse("Eat a potato thu.")
      assert_equal("thu", data[:day])
    end

    def test_parse_date
      data = @@parser.parse("Go to the zoo 3/13")
      assert_equal("3/13", data[:date])
    end

    def test_parse_relative_day
      data = @@parser.parse("Eat a potato tomorrow")
      assert_equal("tomorrow", data[:relative_day])
    end


    def test_label_multiword_at
      data = @@parser.parse("coffee meeting at 12pm")
      assert_equal('coffee meeting', data[:label])
    end

    def test_label_multiword_in
      data = @@parser.parse("coffee meeting in 10min")
      assert_equal('coffee meeting in 10min', data[:label])
    end

    def test_label_multiword_on
      data = @@parser.parse("coffee meeting on 12/4")
      assert_equal('coffee meeting', data[:label])
    end


    def test_label_multiword_duplicate_at
      data = @@parser.parse("meet boss at coffee shop in 12 minutes")
      assert_equal('meet boss at coffee shop in 12 minutes', data[:label])
    end

    def test_label_multiword_duplicate_in
      data = @@parser.parse("catch bus at 12pm")
      assert_equal('catch bus', data[:label])
    end

    def test_label_multiword_duplicate_on
      data = @@parser.parse("eat potatos in restaurant on boat at 12pm")
      assert_equal('eat potatos in restaurant on boat', data[:label])
    end


    def test_time_shorthand_double_digit_pm
      assert_equal('12pm', @@parser.send(:identify_field, :time, "12pm")[:time])
    end

    def test_time_shorthand_double_digit_am
      assert_equal('12am', @@parser.send(:identify_field, :time, "12am")[:time])
    end


    def test_time_longhand_double_digit_no_colon_pm
      assert_equal('1220pm', @@parser.send(:identify_field, :time, "1220pm")[:time])
    end

    def test_time_longhand_double_digit_no_colon_am
      assert_equal('1220am', @@parser.send(:identify_field, :time, "1220am")[:time])
    end


    def test_time_longhand_double_digit_with_colon_am
      assert_equal('12:20am', @@parser.send(:identify_field, :time, "12:20am")[:time])
    end

    def test_time_longhand_double_digit_with_colon_pm
      assert_equal('12:20pm', @@parser.send(:identify_field, :time, "12:20pm")[:time])
    end



    def test_time_with_label_shorthand_double_digit_pm
      assert_equal('12pm', @@parser.send(:identify_field, :time, "meet caroline at 12pm")[:time])
    end

    def test_time_with_label_shorthand_double_digit_am
      assert_equal('12am', @@parser.send(:identify_field, :time, "meet caroline at 12am")[:time])
    end


    def test_time_with_label_longhand_double_digit_no_colon_pm
      assert_equal('1220pm', @@parser.send(:identify_field, :time, "call chris at 1220pm")[:time])
    end

    def test_time_with_label_longhand_double_digit_no_colon_am
      assert_equal('1220am', @@parser.send(:identify_field, :time, "call chris at 1220am")[:time])
    end


    def test_time_with_label_longhand_double_digit_with_colon_am
      assert_equal('12:20am', @@parser.send(:identify_field, :time, "eat dinner at 12:20am")[:time])
    end

    def test_time_with_label_longhand_double_digit_with_colon_pm
      assert_equal('12:20pm', @@parser.send(:identify_field, :time, "eat dinner at 12:20pm")[:time])
    end


    def test_day_monday
      assert_equal('monday', @@parser.send(:identify_field, :day, "wash clothes on monday")[:day])
    end

    def test_day_tuesday
      assert_equal('tuesday', @@parser.send(:identify_field, :day, "feed turtles on tuesday")[:day])
    end

    def test_day_wednesday
      assert_equal('wednesday', @@parser.send(:identify_field, :day, "go to the bank on wednesday")[:day])
    end

    def test_day_thursday
      assert_equal('thursday', @@parser.send(:identify_field, :day, "interview with company on thursday")[:day])
    end

    def test_day_friday
      assert_equal('friday', @@parser.send(:identify_field, :day, "deploy system on friday")[:day])
    end

    def test_day_saturday
      assert_equal('saturday', @@parser.send(:identify_field, :day, "go hiking on saturday")[:day])
    end

    def test_day_sunday
      assert_equal('sunday', @@parser.send(:identify_field, :day, "relax on sunday")[:day])
    end


    def test_date_shorthand
      assert_equal('3/4', @@parser.send(:identify_field, :date, "3/4")[:date])
    end

    def test_date_shorthand_leading_zero
      assert_equal('03/03', @@parser.send(:identify_field, :date, "03/03")[:date])
    end

    def test_date_longhand
      assert_equal('02/14/2014', @@parser.send(:identify_field, :date, "02/14/2014")[:date])
    end


    def test_relative_day_today
      assert_equal('today', @@parser.send(:identify_field, :relative_day, 'play frolf today')[:relative_day])
    end

    def test_relative_day_tomorrow
      assert_equal('tomorrow', @@parser.send(:identify_field, :relative_day, 'pick up cake tomorrow')[:relative_day])
    end
  end
end
