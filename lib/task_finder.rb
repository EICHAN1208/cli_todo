require 'date'
require './lib/storage'
require './lib/task'

class TaskFinder
  extend Storage

  class << self
    def find_by_id(id)
      find(id)
    end

    def find_uncompleted
      load_tasks.select(&:uncompleted?)
    end

    def find_completed
      load_tasks.reject(&:uncompleted?)
    end

    def find_due_date_today
      load_tasks.select(&:due_date_today?)
    end
  end
end
