require 'date'
require "test/unit"
require_relative '../interpreter'
module Scheduler
  class InterpreterTest < Test::Unit::TestCase
    def self.startup
      @@interpreter = Scheduler::Interpreter.new
    end


    def test_interpret_1
      parsed_data = {
        time: '12pm',
        day: Date.today.strftime("%A")
      }
      data = @@interpreter.interpret(parsed_data)
      assert_equal(Time.parse("12:00pm"), data[:time])
      assert_equal(Date.today, data[:date])
    end

    def test_interpret_2
      parsed_data = {
        time: '12am',
        day: (Date.today + 3).strftime("%A")
      }
      data = @@interpreter.interpret(parsed_data)
      assert_equal(Time.parse("12:00am"), data[:time])
      assert_equal(Date.today + 3, data[:date])
    end


    def test_interpret_day_today
      date = @@interpreter.set_date_from_day(Date.today.strftime("%A"))
      assert_equal(Date.today, date)
    end

    def test_interpret_day_tomorrow
      date = @@interpreter.set_date_from_day((Date.today + 1).strftime("%A"))
      assert_equal(Date.today + 1, date)
    end

    def test_interpret_day_day_after_tomorrow
      date = @@interpreter.set_date_from_day((Date.today + 2).strftime("%A"))
      assert_equal(Date.today + 2, date)
    end

    def test_interpret_day_three_days
      date = @@interpreter.set_date_from_day((Date.today + 3).strftime("%A"))
      assert_equal(Date.today + 3, date)
    end

    def test_interpret_day_four_days
      date = @@interpreter.set_date_from_day((Date.today + 4).strftime("%A"))
      assert_equal(Date.today + 4, date)
    end

    def test_interpret_day_five_days
      date = @@interpreter.set_date_from_day((Date.today + 5).strftime("%A"))
      assert_equal(Date.today + 5, date)
    end

    def test_interpret_day_six_days
      date = @@interpreter.set_date_from_day((Date.today + 6).strftime("%A"))
      assert_equal(Date.today + 6, date)
    end


    def test_interpret_time_full
      time = @@interpreter.set_time_from_time("4:00am")
      expected_time = Time.parse('4:00am')
      assert_equal(expected_time.hour, time.hour)
      assert_equal(expected_time.min, time.min)
      assert_equal(expected_time.sec, time.sec)
    end

    def test_interpret_time_short
      time = @@interpreter.set_time_from_time("6am")
      expected_time = Time.parse('6:00am')
      assert_equal(expected_time.hour, time.hour)
      assert_equal(expected_time.min, time.min)
      assert_equal(expected_time.sec, time.sec)
    end

    def test_interpret_date_shorthand
      date = @@interpreter.set_date_from_date("3/4")
      assert_equal(Date.strptime("03/4/#{Date.today.year}", '%m/%d/%Y'), date)
    end

    def test_interpret_date_shorthand_leading_zero
      date = @@interpreter.set_date_from_date("01/25")
      assert_equal(Date.strptime("01/25/#{Date.today.year}", '%m/%d/%Y'), date)
    end

    def test_interpret_date_longhand
      date = @@interpreter.set_date_from_date("1/25/2016")
      assert_equal(Date.strptime("1/25/2016", '%m/%d/%Y'), date)
    end

    def test_interpret_date_longhand_leading_zero
      date = @@interpreter.set_date_from_date("05/25/2018")
      assert_equal(Date.strptime("05/25/2018", '%m/%d/%Y'), date)
    end

    def test_interpret_date_longhand_leading_zero_different
      date = @@interpreter.set_date_from_date("05/25/2018")
      assert_not_equal(Date.strptime("05/23/2018", '%m/%d/%Y'), date)
    end


    def test_relative_day_today
      assert_equal(Date.today, @@interpreter.set_date_from_relative_day('today'))
    end

    def test_relative_day_tomorrow
      assert_equal(Date.today + 1, @@interpreter.set_date_from_relative_day('tomorrow'))
    end
  end
end
