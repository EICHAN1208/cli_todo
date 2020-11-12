require 'csv'

module Storage
  def save
    initialize_csv unless File.exist? './tmp/tasks.csv'
    CSV.open('./tmp/tasks.csv', 'a', force_quotes: true) do |csv|
      csv << attributes
    end
    self
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

  def all
    tasks = []
    CSV.foreach('./tmp/tasks.csv', headers: :first_row) do |row|
      task = row.to_h
      task = Task.new(task['title'], id: task['id'], due_date: task['due_date'], completed_at: task['completed_at'])
      tasks << task
    end
    tasks
  end

  private

  def initialize_csv
    CSV.open('./tmp/tasks.csv', 'w', force_quotes: true) do |csv|
      csv << HEADERS
    end
  end
end
