require './lib/task'
require './lib/task_finder'
require './lib/renderer'

class Router
  class << self
    def route(arg_0, arg_1, arg_2, arg_3)
      case arg_0
      when '--help'
        Renderer.render_help_option
      when 'add'
        return unless option_correct?(arg_2)

        task = Task.add(arg_1, due_date: arg_3)
        Renderer.render(task)
      when 'done'
        task = TaskFinder.find_by_id(arg_1)
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

    def option_correct?(arg_2)
      (arg_2 == '-d') || (arg_2 == '--due') || arg_2.nil?
    end
  end
end
