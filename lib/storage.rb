require 'csv'

module Storage
  def write
    initialize_csv unless File.exist? './tmp/tasks.csv'
    CSV.open('./tmp/tasks.csv', 'a', force_quotes: true) do |csv|
      csv << attributes
    end
    self
  end

  def find(id)
    load_tasks.find { |task| task.id == id }
  end

  def update
    table = CSV.table('./tmp/tasks.csv')
    row = table.find do |r|
      r[:id] == id
    end
    table.delete_if { |r| r == row }
    table << attributes
    File.open('./tmp/tasks.csv', 'w') do |f|
      f.puts table.to_csv
    end
  end

  def load_tasks
    tasks = []
    CSV.foreach('./tmp/tasks.csv', headers: :first_row) do |row|
      task = row.to_h
      load_task = Task.new(task['title'], id: task['id'], due_date: task['due_date'], completed_at: task['completed_at'])
      tasks << load_task
    end
    tasks
  end

  private

  def initialize_csv
    CSV.open('./tmp/tasks.csv', 'w', force_quotes: true) do |csv|
      csv << %w[id due_date completed_at title]
    end
  end
end
