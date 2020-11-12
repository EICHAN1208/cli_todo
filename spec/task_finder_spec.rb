require './lib/task_finder'

RSpec.describe 'TaskFinder' do
  describe '#find_by_id' do
    subject { TaskFinder.find_by_id(id) }

    context '指定したidが存在する場合' do
      let(:id) { Task.add('タスク').id }

      it 'タスクが選択できる' do
        expect(subject).to_not eq nil
      end
    end

    context '指定したidが存在しない場合' do
      let(:id) { '0000' }

      it 'タスクを選択できない' do
        expect(subject).to eq nil
      end
    end
  end

  describe '#find_uncompleted' do
    let(:tasks) { TaskFinder.find_uncompleted }

    context '未完了のタスクが存在する場合' do
      before do
        Task.add('task')
      end

      it '選択したタスクには完了日が入っていない' do
        judgement = tasks.map(&:completed_at).all?(&:empty?)
        expect(judgement).to eq true
      end
    end
  end

  describe '#find_completed' do
    let(:tasks) { TaskFinder.find_completed }

    it '選択したタスクには完了日が入っている' do
      judgement = tasks.map(&:completed_at).all? { |date| !date.empty? }
      expect(judgement).to eq true
    end
  end

  describe '#find_due_date_today' do
    let(:tasks) { TaskFinder.find_due_date_today }

    before do
      Task.add('task', due_date: Date.today.strftime("%m/%d"))
    end

    it '選択したタスクには全て今日の日付が入っている' do
      judgement = tasks.map(&:due_date).all? { |date| date == Date.today }
      expect(judgement).to eq true
    end
  end
end
