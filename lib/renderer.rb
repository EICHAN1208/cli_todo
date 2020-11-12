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
      @tasks = tasks.instance_of?(Task) ? [tasks] : tasks

      erb = ERB.new(template.lines.map(&:strip).join("\n"), trim_mode: '-')
      puts erb.result(binding)
    end

    def template
      <<~TEXT
        <% if @tasks.empty? -%>
          no tasks
        <% else -%>
          <%= format_headers %>
          <% @tasks.each do |task| -%>
            <%= format_attributes(task) %>
          <% end -%>
        <% end -%>
      TEXT
    end

    def format_headers
      format('%-15s%-15s%-20s%-15s', 'id', 'due_date', 'completed_at', 'title')
    end

    def format_attributes(task)
      format('%-15s%-15s%-20s%-15s', task.id, task.due_date, task.completed_at, task.title)
    end
  end
end
