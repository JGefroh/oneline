require "test/unit"
require_relative '../processor'
module Scheduler
  class ProcessorTest < Test::Unit::TestCase
    def setup
      @processor = Scheduler::Processor.new
    end

    def test_process_task_add
      @processor.process('add this task tomorrow')
      @processor.process('add this task today')
      assert_equal(2, @processor.tasks.length)
    end

    def test_process_add_task
      @processor.send(:add_task, 'task to add tomorrow')
      @processor.send(:add_task, 'task to add in 12 minutes')
      @processor.send(:add_task, 'task to add in 15 minutes')
      assert_equal(3, @processor.tasks.length)
    end

    def test_remove_task
      assert_equal(@processor.tasks.length, 0)
      @processor.send(:add_task, 'task to add tomorrow')
      assert_equal(@processor.tasks.length, 1)
      @processor.send(:remove_task, 'remove 0')
      assert_equal(@processor.tasks.length, 0)
    end

    def test_remove_tasks
      @processor.process('first task with index 0 tomorrow')
      @processor.process('second task with index 1 tomorrow')
      task_to_remove = @processor.process('third task with index 2 tomorrow')
      @processor.process('fourth task with index 3 tomorrow')
      @processor.process('fifth task with index 4 tomorrow')
      assert_equal(5, @processor.tasks.length)

      removed_task = @processor.process('remove 2')
      assert_equal(4, @processor.tasks.length)
      assert_equal(task_to_remove.label, removed_task.label)
    end
  end
end
