require 'erb'

class Renderer
  class << self
    def render_help_option
      puts <<-TEXT
          Options:
          -h, --help  output usage information

          Commands:
          add [task title [-d|--due=(YYYY/)MM/DD]
          Add a task

          all
          Output all not-completed tasks

          today
          Output tasks that due until today

          archived
          Output completed tasks

          done [ID]
          Mark a task as done
      TEXT
    end

    def render(tasks)
      tasks = tasks.instance_of?(Task) ? [tasks] : tasks
      return puts 'no tasks' if tasks.empty?

      text = format_attributes
      tasks.each do |task|
        text += "\n" + format('%-15s%-15s%-20s%-15s', task.id, task.due_date, task.completed_at, task.title)
      end
      puts text
    end

    private

    def format_attributes
      format('%-15s%-15s%-20s%-15s', 'id', 'due_date', 'completed_at', 'title')
    end
  end
end
