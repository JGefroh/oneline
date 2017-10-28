require 'date'
require 'time'
require "test/unit"
require_relative '../interpreter'
module Scheduler
  class InterpreterTest < Test::Unit::TestCase
    def self.startup
      @@interpreter = Scheduler::Interpreter.new
    end

    def test_interpret_empty
      parsed_data = {}
      data = @@interpreter.interpret(parsed_data)
      assert_not_equal(true, data[:interpreted])
    end


    def test_interpret_time
      parsed_data = {
        time: '12pm',
      }
      data = @@interpreter.interpret(parsed_data)
      assert_equal(Time.parse("12:00pm"), data[:time])
      assert_equal(true, data[:interpreted])
    end

    def test_interpret_date
      parsed_data = {
        date: '07/14/2017'
      }
      data = @@interpreter.interpret(parsed_data)
      assert_equal(Date.strptime('07/14/2017', '%m/%d/%Y'), data[:date])
      assert_equal(true, data[:interpreted])
    end

    def test_interpret_day
      parsed_data = {
        day: (Date.today + 3).strftime("%A")
      }
      data = @@interpreter.interpret(parsed_data)
      assert_equal(Date.today + 3, data[:date])
      assert_equal(true, data[:interpreted])
    end

    def test_interpret_relative_day
      parsed_data = {
        relative_day: "tomorrow"
      }
      data = @@interpreter.interpret(parsed_data)
      assert_equal(Date.today + 1, data[:date])
      assert_equal(true, data[:interpreted])
    end

    def test_interpret_relative_time
      parsed_data = {
        relative_time: '15min'
      }
      data = @@interpreter.interpret(parsed_data)
      assert_equal((Time.current + (15 * 60)).to_i, data[:time].to_i)
      assert_equal(true, data[:interpreted])
    end



    def test_interpret_day_today
      date = @@interpreter.send(:set_date_from_day, Date.today.strftime("%A"))
      assert_equal(Date.today, date)
    end

    def test_interpret_day_tomorrow
      date = @@interpreter.send(:set_date_from_day, (Date.today + 1).strftime("%A"))
      assert_equal(Date.today + 1, date)
    end

    def test_interpret_day_day_after_tomorrow
      date = @@interpreter.send(:set_date_from_day, (Date.today + 2).strftime("%A"))
      assert_equal(Date.today + 2, date)
    end

    def test_interpret_day_three_days
      date = @@interpreter.send(:set_date_from_day, (Date.today + 3).strftime("%A"))
      assert_equal(Date.today + 3, date)
    end

    def test_interpret_day_four_days
      date = @@interpreter.send(:set_date_from_day, (Date.today + 4).strftime("%A"))
      assert_equal(Date.today + 4, date)
    end

    def test_interpret_day_five_days
      date = @@interpreter.send(:set_date_from_day, (Date.today + 5).strftime("%A"))
      assert_equal(Date.today + 5, date)
    end

    def test_interpret_day_six_days
      date = @@interpreter.send(:set_date_from_day, (Date.today + 6).strftime("%A"))
      assert_equal(Date.today + 6, date)
    end


    def test_interpret_time_full
      time = @@interpreter.send(:set_time_from_time, "4:00am")
      expected_time = Time.zone.parse('4:00am')
      assert_equal(expected_time.hour, time.hour)
      assert_equal(expected_time.min, time.min)
      assert_equal(expected_time.sec, time.sec)
    end

    def test_interpret_time_short
      time = @@interpreter.send(:set_time_from_time, "6am")
      expected_time = Time.zone.parse('6:00am')
      assert_equal(expected_time.hour, time.hour)
      assert_equal(expected_time.min, time.min)
      assert_equal(expected_time.sec, time.sec)
    end

    def test_interpret_date_shorthand
      date = @@interpreter.send(:set_date_from_date, "3/4")
      assert_equal(Date.strptime("03/4/#{Date.today.year}", '%m/%d/%Y'), date)
    end

    def test_interpret_date_shorthand_leading_zero
      date = @@interpreter.send(:set_date_from_date, "01/25")
      assert_equal(Date.strptime("01/25/#{Date.today.year}", '%m/%d/%Y'), date)
    end

    def test_interpret_date_longhand
      date = @@interpreter.send(:set_date_from_date, "1/25/2016")
      assert_equal(Date.strptime("1/25/2016", '%m/%d/%Y'), date)
    end

    def test_interpret_date_longhand_leading_zero
      date = @@interpreter.send(:set_date_from_date, "05/25/2018")
      assert_equal(Date.strptime("05/25/2018", '%m/%d/%Y'), date)
    end

    def test_interpret_date_longhand_leading_zero_different
      date = @@interpreter.send(:set_date_from_date, "05/25/2018")
      assert_not_equal(Date.strptime("05/23/2018", '%m/%d/%Y'), date)
    end


    def test_relative_day_today
      date = @@interpreter.send(:set_date_from_relative_day, 'today')
      assert_equal(Date.today, date)
    end

    def test_relative_day_tomorrow
      date = @@interpreter.send(:set_date_from_relative_day, 'tomorrow')
      assert_equal(Date.today + 1, date)
    end

    def test_relative_time_seconds
      time = @@interpreter.send(:set_time_from_relative_time, '3 seconds')
      assert_equal((Time.current + 3).to_i, time.to_i)
    end

    def test_relative_time_minutes
      time = @@interpreter.send(:set_time_from_relative_time, '10 minutes')
      assert_equal((Time.current + (10 * 60)).to_i, time.to_i)
    end

    def test_relative_time_hours
      time = @@interpreter.send(:set_time_from_relative_time, '20 hours')
      assert_equal((Time.current + (20 * 60 * 60)).to_i, time.to_i)
    end

    def test_relative_time_unit_different
      time = @@interpreter.send(:set_time_from_relative_time, '20 minutes')
      assert_not_equal((Time.current + (20 * 60 * 60)).to_i, time.to_i)
    end
  end
end
