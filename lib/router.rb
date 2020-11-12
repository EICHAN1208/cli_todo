require './lib/task'
require './lib/task_finder'
require './lib/renderer'

class Router
  class << self
    def route(*args)
      case args[0]
      when '--help'
        Renderer.render_help_option
      when 'add'
        return unless correct_option?(args[2])

        task = Task.add(args[1], due_date: args[3])
        Renderer.render(task)
      when 'done'
        task = TaskFinder.find_by_id(args[1])
        task.done
        Renderer.render(task)
      when 'all'
        tasks = TaskFinder.find_uncompleted
        Renderer.render(tasks)
      when 'archived'
        tasks = TaskFinder.find_completed
        Renderer.render(tasks)
      when 'today'
        tasks = TaskFinder.find_due_date_today
        Renderer.render(tasks)
      end
    end

    private

    def correct_option?(arg2)
      (arg2 == '-d') || (arg2 == '--due') || arg2.nil?
    end
  end
end
