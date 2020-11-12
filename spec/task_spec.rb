require 'date'
require './lib/task'
require './lib/task_finder'

RSpec.describe 'Task' do
  describe '#add' do
    subject { Task.add(title, due_date: due_date) }

    context 'd, dueオプションがない場合' do
      let(:title) { 'タスク' }
      let(:due_date) { nil }

      it '初期化されtitleが取得できる' do
        expect(subject.title).to eq('タスク')
      end

      it '期日は取得できない' do
        expect(subject.due_date).to eq(nil)
      end
    end

    context 'd, dueオプションがある場合' do
      let(:title) { 'task' }
      let(:due_date) { '11/11' }

      it 'タスクが取得できる' do
        expect(subject.title).to eq('task')
      end

      it '日付が取得できる' do
        expect(subject.due_date.strftime).to eq('2020-11-11')
      end
    end
  end

  describe '#done' do
    context '指定idのタスクがある場合' do
      let(:created_task) { Task.add('task')}
      let(:task) { TaskFinder.find_by_id(created_task.id) }

      it '今日の日付が完了日に入る' do
        task.done
        expect(task.completed_at).to eq(Date.today)
      end
    end

    context 'idが間違っている場合' do
      let(:created_task_1) { Task.add('task') }
      let(:task) { TaskFinder.find_by_id('1111') }

      it '日付が完了日に入らない' do
        task.done
        expect(task.completed_at).to_not eq(Date.today)
      end
    end
  end
end
