require 'test_helper'
require_relative './mocks/mock_console_renderer'

class ScheduledItemTest < ActiveSupport::TestCase
  def notify?(run_at)
    time = Time.current
    return run_at >= time
  end

  def test_notify_empty
    s = ListItem.new({})
    assert_equal(false, notify?(s.calculate_run_at))
  end

  def test_notify_no_date_past_time
    s = ListItem.new({time: Time.current - 1})
    assert_equal(true, notify?(s.calculate_run_at))
  end

  def test_notify_no_date_future_time
    s = ListItem.new({time: Time.current + 1})
    assert_equal(false, notify?(s.calculate_run_at))
  end

  def test_notify_no_date_present_time
    s = ListItem.new({time: Time.current})
    assert_equal(true, notify?(s.calculate_run_at))
  end


  def test_notify_past_date_no_time
    s = ListItem.new({date: Date.today - 1})
    assert_equal(true, notify?(s.calculate_run_at))
  end

  def test_notify_future_date_no_time
    s = ListItem.new({date: Date.today + 1})
    assert_equal(false, notify?(s.calculate_run_at))
  end

  def test_notify_present_date_no_time
    s = ListItem.new({date: Date.today})
    assert_equal(true, notify?(s.calculate_run_at))
  end


  def test_notify_past_date_past_time
    s = ListItem.new({date: Date.today - 10000, time: Time.current - 1})
    assert_equal(true, notify?(s.calculate_run_at))
  end

  def test_notify_past_date_future_time
    s = ListItem.new({date: Date.today - 10000, time: Time.current + 1})
    assert_equal(true, notify?(s.calculate_run_at))
  end

  def test_notify_present_date_past_time
    s = ListItem.new({date: Date.today, time: Time.current - 1})
    assert_equal(true, notify?(s.calculate_run_at))
  end

  def test_notify_present_date_future_time
    s = ListItem.new({date: Date.today, time: Time.current + 1})
    assert_equal(false, notify?(s.calculate_run_at))
  end

  def test_notify_future_date_past_time
    s = ListItem.new({date: Date.today + 2, time: Time.current - 1})
    assert_equal(false, notify?(s.calculate_run_at))
  end

  def test_notify_future_date_future_time
    s = ListItem.new({date: Date.today + 1, time: Time.current + 1})
    assert_equal(false, notify?(s.calculate_run_at))
  end



  def test_notify_past_already_notified
    s = ListItem.new({date: Date.today - 10, time: Time.current - 1})
    s.notified_at = Time.current
    assert_equal(false, notify?(s.calculate_run_at))
  end

end
