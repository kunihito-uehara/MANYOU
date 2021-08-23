#describeには、「何の仕様についてなのか」（テスト対象）、contextには「状況・状態を分類」したテスト内容、
#itには「期待する動作」を記載

require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される+ステータス変更' do
      # visit new_task_path 
      # fill_in "task[title]", with: 'あいうえお'
      # fill_in "task[content]", with: 'かきくけこ'
      #   select "2021", from: 'task[expiration_date(1i)]'
      #   select "1月", from: 'task[expiration_date(2i)]'
      #   select "2", from: 'task[expiration_date(3i)]'
      #   select "未着手", from: 'task[status]'
      #   select "高", from: 'task[priority]'
      # click_on '登録する'
      #FactoryBot.create(:task,:content,:expiration_date,:status,:priority)

      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      visit tasks_path
      click_on '終了期限で並べ替える'
      expect(page).to have_content 'ファースト'
      expect(page).to have_content 'セカンド'

        # expect(page).to have_content '新しいタスクを作成しました！'
        # expect(page).to have_content 'あいうえお'
        # expect(page).to have_content 'かきくけこ'
        # expect(page).to have_content '1/2'
        # expect(page).to have_content '未着手'
        # expect(page).to have_content '高'
        # expect(page).to have_content '並び替え'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task= FactoryBot.create(:task, content: 'かきくけこ')
        FactoryBot.create(:second_task)
        visit tasks_path
        expect(page).to have_content 'かきくけこ'
        expect(page).to have_content 'セカンド'
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

  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      task = FactoryBot.create(:task, title: 'なにぬねの')
      visit tasks_path
      task_list = all('.title')
      expect(task_list[0]).to have_content 'なにぬねの' 
    end
  end
  describe '検索機能' do
    before do
      #FactoryBot.create(:task)
      #FactoryBot.create(:second_task)
      FactoryBot.create(:task,title: '検索テスト')
      FactoryBot.create(:second_task, title: '検索テスト2')
      visit tasks_path
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
      fill_in 'search_title', with: '検索テスト'
        click_button '検索'
        expect(page).to have_content '検索テスト'
      end
    end

    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select "未着手", from: 'search_status'
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'search_title', with: '検索テスト'
        select "着手中", from: 'search_status'
        click_on '検索'
        expect(page).to have_content '検索テスト'
        expect(page).to have_content '着手中'
      end
    end
  end
end
