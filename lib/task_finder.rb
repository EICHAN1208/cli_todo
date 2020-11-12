require 'date'
require './lib/storage'
require './lib/task'

class TaskFinder
  extend Storage

  class << self
    def find_by_id(id)
      all.find { |task| task.id == id }
    end

    def find_uncompleted
      all.select(&:uncompleted?)
    end

    def find_completed
      all.reject(&:uncompleted?)
    end

    def find_due_date_today
      all.select(&:due_date_today?)
    end
  end
end
