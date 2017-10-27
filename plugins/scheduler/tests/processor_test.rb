require "test/unit"
require_relative '../processor'
require_relative 'mocks/mock_console_renderer'
module Scheduler
  class ProcessorTest < Test::Unit::TestCase
    def setup
      @processor = Scheduler::Processor.new
      @processor.renderer = Scheduler::MockConsoleRenderer.new
    end

    def test_process_tasks_add
      @processor.process('add this task tomorrow', 'user1')
      @processor.process('add this task today', 'user1')
      assert_equal(2, @processor.tasks_for('user1').length)
    end

    def test_process_tasks_remove
      @processor.process('first task with index 0 tomorrow', 'user1')
      @processor.process('second task with index 1 tomorrow', 'user1')
      task_to_remove = @processor.process('third task with index 2 tomorrow', 'user1')
      @processor.process('fourth task with index 3 tomorrow', 'user1')
      @processor.process('fifth task with index 4 tomorrow', 'user1')
      assert_equal(5, @processor.tasks_for('user1').length)

      result = @processor.process('remove 2', 'user1')
      assert_equal(4, @processor.tasks_for('user1').length)
      assert_equal(result[:data].label, result[:data].label)
    end

    def test_add_task
      @processor.send(:add_task, {label: 'task 1', date: Date.today}, 'user1')
      @processor.send(:add_task,  {label: 'task 2', date: Date.today}, 'user1')
      @processor.send(:add_task,  {label: 'task 3', date: Date.today}, 'user1')
      assert_equal(3, @processor.tasks_for('user1').length)
    end

    def test_remove_task
      assert_equal(0, @processor.tasks_for('user1').length)
      @processor.send(:add_task, {label: 'task 0', date: Date.today, interpreted: true, command: 'add'}, 'user1')
      @processor.send(:add_task, {label: 'task 1', date: Date.today, interpreted: true, command: 'add'}, 'user1')
      @processor.send(:add_task, {label: 'task 2', date: Date.today, interpreted: true, command: 'add'}, 'user1')
      @processor.send(:add_task, {label: 'task 3', date: Date.today, interpreted: true, command: 'add'}, 'user1')
      @processor.send(:add_task, {label: 'task 4', date: Date.today, interpreted: true, command: 'add'}, 'user1')
      assert_equal(5, @processor.tasks_for('user1').length)
      removed_task = @processor.send(:remove_task, {command: 'remove', remove_index: 2, interpreted: true}, 'user1')
      assert_equal(4, @processor.tasks_for('user1').length)
      assert_equal(removed_task.label, 'task 2')
    end
  end
end
