#describeには、「何の仕様についてなのか」（テスト対象）、contextには「状況・状態を分類」したテスト内容、
#itには「期待する動作」を記載

require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # テストで使用するためのタスクを作成
      #FactoryBot.create(:task, content: 'task')
      #FactoryBot.create(:second_task)
      #FactoryBot.create(:third_task)
      #FactoryBot.create(:fourth_task)
      # タスク一覧ページに遷移
      visit new_task_path #タスクページへ行く
      # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
      # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
      #expect(page).to have_content 'task'

      #click_on '追加'
      fill_in "task[title]", with: 'タイトル'
      fill_in "task[content]", with: 'あいうえお'
      click_on '登録する'
      expect(page).to have_content 'タイトル'
      expect(page).to have_content 'あいうえお'
      # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task= FactoryBot.create(:task, content: 'かきくけこ')
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
        FactoryBot.create(:fourth_task)
        FactoryBot.create(:second_task, content: 'さしすせそ')

        visit tasks_path

        expect(page).to have_content 'かきくけこ'
        expect(page).to have_content 'さしすせそ'
        expect(page).to have_content 'second_task_content'
        expect(page).to have_content 'third_task_content'
        expect(page).to have_content 'fourth_task_content'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, content: 'たちつてと')
        task2 = FactoryBot.create(:task, content: 'かきくけこ')
        visit tasks_path
        visit task_path(task)
        expect(page).to have_content 'たちつてと'
        expect(page).not_to have_content 'かきくけこ'
        end
    end
  end
end