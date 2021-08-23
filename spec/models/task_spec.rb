require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト', expiration_date: '2022-01-01', status: '着手中', priority: '中')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: "失敗テスト", content: "")
        expect(task).to be_invalid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', expiration_date: '2022-01-01')
        expect(task).to be_valid
      end
    end
  end
  #  scopeメソッドでタイトルのあいまい検索
  #  scopeメソッドでステータス検索
  #  scopeメソッドでタイトルとステータスの両方が検索
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'ファースト', expiration_date: '2022-01-01', status: '未着手', priority: '中') }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'セカンド', expiration_date: '2022-01-02', status: '着手中', priority: '中') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('ファースト')).to include(task)
        expect(Task.search_title('ノット')).not_to include(second_task)
        expect(Task.search_title('ファースト').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('未着手')).to include(task)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('ファースト')).to include(task)
        expect(Task.search_title('ノット')).not_to include(second_task)
        expect(Task.search_title('ファースト').count).to eq 1
        expect(Task.search_status('未着手')).to include(task)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
  end
end