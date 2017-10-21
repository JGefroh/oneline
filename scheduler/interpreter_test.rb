require 'date'
require "test/unit"
require_relative 'interpreter'
module Scheduler
  class InterpreterTest < Test::Unit::TestCase
    def self.startup
      @@interpreter = Scheduler::Interpreter.new
    end

    def test_interpret_day_today
      parsed_text = {
        day: Date.today.strftime("%A")
      }
      interpreted_data = @@interpreter.interpret(parsed_text)
      assert_equal(Date.today, interpreted_data[:date])
    end

    def test_interpret_day_tomorrow
      parsed_text = {
        day: (Date.today + 1).strftime("%A")
      }
      interpreted_data = @@interpreter.interpret(parsed_text)
      assert_equal(Date.today + 1, interpreted_data[:date])
    end

    def test_interpret_day_day_after_tomorrow
      parsed_text = {
        day: (Date.today + 2).strftime("%A")
      }
      interpreted_data = @@interpreter.interpret(parsed_text)
      assert_equal(Date.today + 2, interpreted_data[:date])
    end

    def test_interpret_day_three_days
      parsed_text = {
        day: (Date.today + 3).strftime("%A")
      }
      interpreted_data = @@interpreter.interpret(parsed_text)
      assert_equal(Date.today + 3, interpreted_data[:date])
    end

    def test_interpret_day_four_days
      parsed_text = {
        day: (Date.today + 4).strftime("%A")
      }
      interpreted_data = @@interpreter.interpret(parsed_text)
      assert_equal(Date.today + 4, interpreted_data[:date])
    end

    def test_interpret_day_five_days
      parsed_text = {
        day: (Date.today + 5).strftime("%A")
      }
      interpreted_data = @@interpreter.interpret(parsed_text)
      assert_equal(Date.today + 5, interpreted_data[:date])
    end

    def test_interpret_day_six_days
      parsed_text = {
        day: (Date.today + 6).strftime("%A")
      }
      interpreted_data = @@interpreter.interpret(parsed_text)
      assert_equal(Date.today + 6, interpreted_data[:date])
    end
  end
end
