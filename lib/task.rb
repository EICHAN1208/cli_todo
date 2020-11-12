require 'securerandom'
require 'date'
require './lib/storage'

class Task
  include Storage

  attr_reader :id, :due_date, :completed_at, :title

  class << self
    def add(title, due_date: nil)
      task = new(title, due_date: due_date)
      task.write
    end
  end

  def initialize(title, id: SecureRandom.hex(3), due_date: nil, completed_at: nil)
    @title = title
    @id = id
    @due_date = blank?(due_date) ? nil : Date.parse(due_date)
    @completed_at = completed_at
  end

  def done
    @completed_at = Date.today
    update
  end

  def uncompleted?
    completed_at.empty?
  end

  def due_date_today?
    due_date == Date.today
  end

  def attributes
    [id, due_date, completed_at, title]
  end

  private

  def blank?(due_date)
    due_date.nil? || due_date.empty?
  end
end
