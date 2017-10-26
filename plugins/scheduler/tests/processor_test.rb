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
      @processor.process('add this task tomorrow')
      @processor.process('add this task today')
      assert_equal(2, @processor.tasks.length)
    end

    def test_process_tasks_remove
      @processor.process('first task with index 0 tomorrow')
      @processor.process('second task with index 1 tomorrow')
      task_to_remove = @processor.process('third task with index 2 tomorrow')
      @processor.process('fourth task with index 3 tomorrow')
      @processor.process('fifth task with index 4 tomorrow')
      assert_equal(5, @processor.tasks.length)

      result = @processor.process('remove 2')
      assert_equal(4, @processor.tasks.length)
      assert_equal(result[:data].label, result[:data].label)
    end

    def test_add_task
      @processor.send(:add_task, {label: 'task 1', date: Date.today})
      @processor.send(:add_task,  {label: 'task 2', date: Date.today})
      @processor.send(:add_task,  {label: 'task 3', date: Date.today})
      assert_equal(3, @processor.tasks.length)
    end

    def test_remove_task
      assert_equal(0, @processor.tasks.length)
      @processor.send(:add_task, {label: 'task 0', date: Date.today, interpreted: true, command: 'add'})
      @processor.send(:add_task, {label: 'task 1', date: Date.today, interpreted: true, command: 'add'})
      @processor.send(:add_task, {label: 'task 2', date: Date.today, interpreted: true, command: 'add'})
      @processor.send(:add_task, {label: 'task 3', date: Date.today, interpreted: true, command: 'add'})
      @processor.send(:add_task, {label: 'task 4', date: Date.today, interpreted: true, command: 'add'})
      assert_equal(5, @processor.tasks.length)
      removed_task = @processor.send(:remove_task, {command: 'remove', remove_index: 2, interpreted: true})
      assert_equal(4, @processor.tasks.length)
      assert_equal(removed_task.label, 'task 2')
    end
  end
end
