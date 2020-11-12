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
      let(:created_task) { Task.add('task') }
      let(:unmatch_id) { created_task.id.chars.shuffle.join }
      let(:task) { TaskFinder.find_by_id(unmatch_id) }

      it 'タスクが存在しない' do
        expect(task).to eq nil
      end
    end
  end

  describe '#uncompleted?' do
    subject { task.uncompleted? }

    context '完了日が入っている場合' do
      let(:created_task) { Task.add('タスク') }
      let(:task) { TaskFinder.find_by_id(created_task.id) }

      before do
        task.done
      end

      it 'falseとなる' do # task.completed_atがオブジェクトになる
        expect(subject).to eq true
      end
    end

    context '完了日が入っていない場合' do
      let(:task) { Task.add('タスク') }

      it 'trueとなる' do  # task.completed_atがnilになる
        expect(subject).to eq true
      end
    end
  end

  describe '#due_date_today?' do
    context '今日の日付が入っている場合' do
      it 'trueとなる' do

      end
    end

    context '日付が入っていない, 今日の日付ではない場合' do
      it 'falseとなる' do

      end
    end
  end

  describe '#attributes' do
    let(:created_task) { Task.new('タスク') }
    # let(:task) { created_task.id = '1111' }

    it 'それぞれのタスクの属性が表示される' do
      expect(task.attributes).to eq ["d5111d", nil, nil, "タスク"]
    end
  end
end
