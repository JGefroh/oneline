require "test/unit"
require 'date'
require_relative '../scheduled_item'
module Scheduler
  class ScheduledItemTest < Test::Unit::TestCase
    def test_notify_empty
      s = Scheduler::ScheduledItem.new({})
      assert_equal(false, s.notify?)
    end


    def test_notify_no_date_past_time
      s = Scheduler::ScheduledItem.new({time: Time.now - 1})
      assert_equal(true, s.notify?)
    end

    def test_notify_no_date_future_time
      s = Scheduler::ScheduledItem.new({time: Time.now + 1})
      assert_equal(false, s.notify?)
    end

    def test_notify_no_date_present_time
      s = Scheduler::ScheduledItem.new({time: Time.now})
      assert_equal(true, s.notify?)
    end


    def test_notify_past_date_no_time
      s = Scheduler::ScheduledItem.new({date: Date.today - 1})
      assert_equal(true, s.notify?)
    end

    def test_notify_future_date_no_time
      s = Scheduler::ScheduledItem.new({date: Date.today + 1})
      assert_equal(false, s.notify?)
    end

    def test_notify_present_date_no_time
      s = Scheduler::ScheduledItem.new({date: Date.today})
      assert_equal(true, s.notify?)
    end


    def test_notify_past_date_past_time
      s = Scheduler::ScheduledItem.new({date: Date.today - 10000, time: Time.now - 1})
      assert_equal(true, s.notify?)
    end

    def test_notify_past_date_future_time
      s = Scheduler::ScheduledItem.new({date: Date.today - 10000, time: Time.now + 1})
      assert_equal(true, s.notify?)
    end

    def test_notify_present_date_past_time
      s = Scheduler::ScheduledItem.new({date: Date.today, time: Time.now - 1})
      assert_equal(true, s.notify?)
    end

    def test_notify_present_date_future_time
      s = Scheduler::ScheduledItem.new({date: Date.today, time: Time.now + 1})
      assert_equal(false, s.notify?)
    end

    def test_notify_future_date_past_time
      s = Scheduler::ScheduledItem.new({date: Date.today + 2, time: Time.now - 1})
      assert_equal(false, s.notify?)
    end

    def test_notify_future_date_future_time
      s = Scheduler::ScheduledItem.new({date: Date.today + 1, time: Time.now + 1})
      assert_equal(false, s.notify?)
    end



    def test_notify_past_already_notified
      s = Scheduler::ScheduledItem.new({last_notified: Time.now, date: Date.today - 10, time: Time.now - 1})
      assert_equal(false, s.notify?)
    end

  end
end
