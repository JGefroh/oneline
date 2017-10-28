require 'test_helper'

class ListItemTest < ActiveSupport::TestCase
  def test_notify_empty
    s = ListItem.new({})
    assert_equal(false, s.notify?)
  end

  def test_notify_no_date_past_time
    s = ListItem.new({time: DateTime.current - 10})
    assert_equal(true, s.notify?)
  end

  def test_notify_no_date_future_time
    s = ListItem.new({time: DateTime.current + 10})
    assert_equal(false, s.notify?)
  end

  def test_notify_no_date_present_time
    s = ListItem.new({time: DateTime.current})
    assert_equal(true, s.notify?)
  end


  def test_notify_past_date_no_time
    s = ListItem.new({date: Date.today - 10})
    assert_equal(true, s.notify?)
  end

  def test_notify_future_date_no_time
    s = ListItem.new({date: Date.today + 10})
    assert_equal(false, s.notify?)
  end

  def test_notify_present_date_no_time
    s = ListItem.new({date: Date.today})
    assert_equal(true, s.notify?)
  end


  def test_notify_past_date_past_time
    s = ListItem.new({date: Date.today - 10, time: DateTime.current - 10})
    assert_equal(true, s.notify?)
  end

  def test_notify_past_date_future_time
    s = ListItem.new({date: Date.today - 10, time: DateTime.current + 10})
    assert_equal(true, s.notify?)
  end

  def test_notify_present_date_past_time
    s = ListItem.new({date: Date.today, time: DateTime.current - 10})
    assert_equal(true, s.notify?)
  end

  def test_notify_present_date_future_time
    s = ListItem.new({date: Date.today, time: Time.current + 10})
    assert_equal(false, s.notify?)
  end

  def test_notify_future_date_past_time
    s = ListItem.new({date: Date.today + 10, time: DateTime.current - 10})
    assert_equal(false, s.notify?)
  end

  def test_notify_future_date_future_time
    s = ListItem.new({date: Date.today + 10, time: DateTime.current + 10})
    assert_equal(false, s.notify?)
  end



  def test_notify_past_already_notified
    s = ListItem.new({date: Date.today - 10, time: DateTime.current - 10})
    s.notified_at = DateTime.current
    assert_equal(false, s.notify?)
  end
end
