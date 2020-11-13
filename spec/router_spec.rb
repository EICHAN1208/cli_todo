require './lib/router'

RSpec.describe 'Router' do
  subject { Router.route(arg_0, arg_1, arg_2, arg_3) }

  context '--helpの場合' do
    let(:arg_0) { '--help' }
    let(:arg_1) { nil }
    let(:arg_2) { nil }
    let(:arg_3) { nil }

    before do
      allow(Renderer).to receive(:render_help_option).and_return(nil)
    end

    it 'render_help_optionが実行される' do
      subject
      expect(Renderer).to have_received(:render_help_option).once
    end
  end

  context 'add' do
    context '-d, --dueがない場合' do
      let(:arg_0) { 'add' }
      let(:arg_1) { 'task' }
      let(:arg_2) { nil }
      let(:arg_3) { nil }

      before do
        task_mock = double('Task')
        allow(task_mock).to receive(:add)
        allow(Task).to receive(:add).and_return(task_mock)

        allow(Renderer).to receive(:render).and_return(nil)
      end

      it 'addが実行できる' do
        subject
        expect(Task).to have_received(:add).once
      end

      it 'renderが実行できる' do
        subject
        expect(Renderer).to have_received(:render).once
      end
    end

    context '-d, --dueが間違えている場合' do
      let(:arg_0) { 'add' }
      let(:arg_1) { 'task' }
      let(:arg_2) { 'uncorrect' }
      let(:arg_3) { nil }

      it 'correct_optionメソッドが実行されnilが返る' do
        is_expected.to eq nil
      end
    end

    context '-d, --dueが指定されている場合' do
      let(:arg_0) { 'add' }
      let(:arg_1) { 'task' }
      let(:arg_2) { '-d' }
      let(:arg_3) { '12/1' }

      before do
        task_mock = double('Task')
        allow(task_mock).to receive(:add)
        allow(Task).to receive(:add).and_return(task_mock)

        allow(Renderer).to receive(:render).and_return(nil)
      end

      it 'addが実行できて、引数の内容が正しい' do
        subject
        expect(Task).to have_received(:add).with('task', due_date: '12/1').once
      end

      it 'renderが実行できる' do
        subject
        expect(Renderer).to have_received(:render).once
      end
    end
  end

  context 'done' do
    let(:arg_0) { 'done' }
    let(:arg_1) { 'id' }
    let(:arg_2) { nil }
    let(:arg_3) { nil }
    let(:task_mock) { double('FindedTask') }

    before do
      allow(task_mock).to receive(:done)
      allow(TaskFinder).to receive(:find_by_id).and_return(task_mock)
      allow(Renderer).to receive(:render).and_return(nil)
    end

    it 'find_by_idが実行できる' do
      subject
      expect(TaskFinder).to have_received(:find_by_id).once
    end

    it 'task.doneが実行できる' do
      subject
      expect(task_mock).to have_received(:done).once
    end

    it 'renderが実行できる' do
      subject
      expect(Renderer).to have_received(:render).once
    end
  end

  context 'all' do
    let(:arg_0) { 'all' }
    let(:arg_1) { nil }
    let(:arg_2) { nil }
    let(:arg_3) { nil }

    before do
      task_finder_mock = double('TaskFinder')
      allow(task_finder_mock).to receive(:find_uncompleted)
      allow(TaskFinder).to receive(:find_uncompleted).and_return(task_finder_mock)

      allow(Renderer).to receive(:render).and_return(nil)
    end

    it 'find_uncompletedが実行できる' do
      subject
      expect(TaskFinder).to have_received(:find_uncompleted).once
    end

    it 'renderが実行できる' do
      subject
      expect(Renderer).to have_received(:render).once
    end
  end

  context 'archived' do
    let(:arg_0) { 'archived' }
    let(:arg_1) { nil }
    let(:arg_2) { nil }
    let(:arg_3) { nil }

    before do
      task_finder_mock = double('TaskFinder')
      allow(task_finder_mock).to receive(:find_completed)
      allow(TaskFinder).to receive(:find_completed).and_return(task_finder_mock)

      allow(Renderer).to receive(:render).and_return(nil)
    end

    it 'find_completedが実行できる' do
      subject
      expect(TaskFinder).to have_received(:find_completed).once
    end

    it 'renderが実行できる' do
      subject
      expect(Renderer).to have_received(:render).once
    end
  end

  context 'today' do
    let(:arg_0) { 'today' }
    let(:arg_1) { nil }
    let(:arg_2) { nil }
    let(:arg_3) { nil }

    before do
      task_finder_mock = double('TaskFinder')
      allow(task_finder_mock).to receive(:find_due_date_today)
      allow(TaskFinder).to receive(:find_due_date_today).and_return(task_finder_mock)

      allow(Renderer).to receive(:render).and_return(nil)
    end

    it 'find_due_date_todayが実行できる' do
      subject
      expect(TaskFinder).to have_received(:find_due_date_today).once
    end

    it 'renderが実行できる' do
      subject
      expect(Renderer).to have_received(:render).once
    end
  end
end


# task_mock = double("TodoTask") 空のモックオブジェクトを作る
# allow(task_mock).to receive(:add(----)) モックに返事の仕方を教え込む
# allow(Task).to receive(:add()).and_return(task_mock) アプリケーションコードにモックに送り込む