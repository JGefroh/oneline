require 'date'
require "test/unit"
require_relative 'interpreter'
module Scheduler
  class InterpreterTest < Test::Unit::TestCase
    def self.startup
      @@interpreter = Scheduler::Interpreter.new
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
  end
end
