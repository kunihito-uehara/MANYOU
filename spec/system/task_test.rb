#STEP1

#describe、「何の仕様についてなのか」（テスト対象）、contextには「状況・状態を分類」したテスト内容
#it「期待する動作」を記載
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # テストで使用するためのタスクを作成
        FactoryBot.create(:task, title: 'タスク')
        FactoryBot.create(:task, content: '内容')
        #Task.create!(title: 'test_task_01', content: 'test_content_01')
        #FactoryBot.create(:task, title: 'task'content: 'task2')
        
      # タスク一覧ページに遷移
      visit tasks_path
      # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
      # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
      expect(page).to have_content 'task'
      fill_in "task[content]", with: 'あいうえooooooooooo'
      expect(page).to have_content 'あいうえooooooooooo'
      # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task, content: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
    it '該当タスクの内容が表示される' do
      task = FactoryBot.create(:task, content: 'task')
      visit show_tasks_path
      binding.irb
        click_on '確認'
        expect(page).to have_content 'task'
      end
    end
  end
end