require "test/unit"
require_relative '../parser'
module Scheduler
  class ParserTest < Test::Unit::TestCase
    def self.startup
      @@parser = Scheduler::Parser.new
    end

    def test_junk_text
      data = @@parser.parse("junk text")
    end


    def test_label_at
      data = @@parser.parse("meeting at 12pm")
    end


    def test_parse_1
      data = @@parser.parse("Go to the store at 12pm on Friday.")
      assert_equal("12pm", data[:time])
      assert_equal("Friday", data[:day])
    end

    def test_parse_2
      data = @@parser.parse("Eat a potato at 3:00pm on thu.")
      assert_equal("3:00pm", data[:time])
      assert_equal("thu", data[:day])
    end


    def test_label_multiword_at
      data = @@parser.parse("coffee meeting at 12pm")
    end

    def test_label_multiword_in
      data = @@parser.parse("coffee meeting in 10min")
    end

    def test_label_multiword_on
      data = @@parser.parse("coffee meeting on 12/4")
    end


    def test_label_multiword_duplicate_at
      data = @@parser.parse("meet boss at coffee shop in 12 minutes")
    end

    def test_label_multiword_duplicate_in
      data = @@parser.parse("catch bus at 12pm")
    end

    def test_label_multiword_duplicate_on
      data = @@parser.parse("eat potatos in restaurant on boat at 12pm")
    end


    def test_time_shorthand_double_digit_pm
      assert_equal('12pm', @@parser.identify_time("12pm"))
    end

    def test_time_shorthand_double_digit_am
      assert_equal('12am', @@parser.identify_time("12am"))
    end


    def test_time_longhand_double_digit_no_colon_pm
      assert_equal('1220pm', @@parser.identify_time("1220pm"))
    end

    def test_time_longhand_double_digit_no_colon_am
      assert_equal('1220am', @@parser.identify_time("1220am"))
    end


    def test_time_longhand_double_digit_with_colon_am
      assert_equal('12:20am', @@parser.identify_time("12:20am"))
    end

    def test_time_longhand_double_digit_with_colon_pm
      assert_equal('12:20pm', @@parser.identify_time("12:20pm"))
    end



    def test_time_with_label_shorthand_double_digit_pm
      assert_equal('12pm', @@parser.identify_time("meet caroline at 12pm"))
    end

    def test_time_with_label_shorthand_double_digit_am
      assert_equal('12am', @@parser.identify_time("meet caroline at 12am"))
    end


    def test_time_with_label_longhand_double_digit_no_colon_pm
      assert_equal('1220pm', @@parser.identify_time("call chris at 1220pm"))
    end

    def test_time_with_label_longhand_double_digit_no_colon_am
      assert_equal('1220am', @@parser.identify_time("call chris at 1220am"))
    end


    def test_time_with_label_longhand_double_digit_with_colon_am
      assert_equal('12:20am', @@parser.identify_time("eat dinner at 12:20am"))
    end

    def test_time_with_label_longhand_double_digit_with_colon_pm
      assert_equal('12:20pm', @@parser.identify_time("eat dinner at 12:20pm"))
    end


    def test_day_monday
      assert_equal('monday', @@parser.identify_day("wash clothes on monday"))
    end

    def test_day_tuesday
      assert_equal('tuesday', @@parser.identify_day("feed turtles on tuesday"))
    end

    def test_day_wednesday
      assert_equal('wednesday', @@parser.identify_day("go to the bank on wednesday"))
    end

    def test_day_thursday
      assert_equal('thursday', @@parser.identify_day("interview with company on thursday"))
    end

    def test_day_friday
      assert_equal('friday', @@parser.identify_day("deploy system on friday"))
    end

    def test_day_saturday
      assert_equal('saturday', @@parser.identify_day("go hiking on saturday"))
    end

    def test_day_sunday
      assert_equal('sunday', @@parser.identify_day("relax on sunday"))
    end

    def test_date_shorthand
      assert_equal('1/24', @@parser.identify_date("1/24"))
    end

    def test_date_shorthand_leading_zero
      assert_equal('03/03', @@parser.identify_date("03/03"))
    end

    def test_date_longhand
      assert_equal('02/14/2014', @@parser.identify_date("02/14/2014"))
    end
  end
end
