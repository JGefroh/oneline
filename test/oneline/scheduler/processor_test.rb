require 'test_helper'
require_relative './mocks/mock_console_renderer'

class ProcessorTest < ActiveSupport::TestCase
  def setup
    @processor = Scheduler::Processor.new
    @processor.renderer = Scheduler::Mocks::MockConsoleRenderer.new
  end

  def test_process_list_items_add
    @processor.process('add this list_item tomorrow', 'user1')
    @processor.process('add this list_item today', 'user1')
    assert_equal(2, ListItem.where(user_identifier: 'user1').count)
  end

  def test_process_list_items_remove
    @processor.process('first list_item with index 0 tomorrow', 'user1')
    @processor.process('second list_item with index 1 tomorrow', 'user1')
    list_item_to_remove = @processor.process('third list_item with index 2 tomorrow', 'user1')
    @processor.process('fourth list_item with index 3 tomorrow', 'user1')
    @processor.process('fifth list_item with index 4 tomorrow', 'user1')
    assert_equal(5, ListItem.where(user_identifier: 'user1').count)

    result = @processor.process('remove 2', 'user1')
    assert_equal(4, ListItem.where(user_identifier: 'user1').count)
    assert_equal(result[:data].label, result[:data].label)
  end

  def test_add_list_item
    @processor.send(:add_list_item, {label: 'list_item 1', date: Date.today}, 'user1')
    @processor.send(:add_list_item,  {label: 'list_item 2', date: Date.today}, 'user1')
    @processor.send(:add_list_item,  {label: 'list_item 3', date: Date.today}, 'user1')
    assert_equal(3, ListItem.where(user_identifier: 'user1').count)
  end

  def test_remove_list_item
    assert_equal(0, ListItem.where(user_identifier: 'user1').count)
    @processor.send(:add_list_item, {label: 'list_item 0', date: Date.today, interpreted: true, command: 'add'}, 'user1')
    @processor.send(:add_list_item, {label: 'list_item 1', date: Date.today, interpreted: true, command: 'add'}, 'user1')
    @processor.send(:add_list_item, {label: 'list_item 2', date: Date.today, interpreted: true, command: 'add'}, 'user1')
    @processor.send(:add_list_item, {label: 'list_item 3', date: Date.today, interpreted: true, command: 'add'}, 'user1')
    @processor.send(:add_list_item, {label: 'list_item 4', date: Date.today, interpreted: true, command: 'add'}, 'user1')
    assert_equal(5, ListItem.where(user_identifier: 'user1').count)
    removed_list_item = @processor.send(:remove_list_item, {command: 'remove', remove_index: 2, interpreted: true}, 'user1')
    assert_equal(4, ListItem.where(user_identifier: 'user1').count)
    assert_equal(removed_list_item.label, 'list_item 2')
  end
end
