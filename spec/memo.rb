require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user, full_name:'TestUser', email: 'testuser@example.com')
    @admin_user = FactoryBot.create(:admin_user)
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
    FactoryBot.create(:third_task, user: @user)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it '作成したタスクが表示される' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
        # 2. 新規登録内容を入力する
        fill_in 'task[name]', with: 'Test Name'
        fill_in 'task[description]', with: 'Test Description'
        select "2021", from: 'task[expiration_date(1i)]'
        select "11月", from: 'task[expiration_date(2i)]'
        select "10", from: 'task[expiration_date(3i)]'
        select "18", from: 'task[expiration_date(4i)]'
        select "15", from: 'task[expiration_date(5i)]'
        select "未着手", from: 'task[status]'
        select "高", from: 'task[priority]'
        # 3. 「登録」というvalue（表記文字）のあるボタンをクリックする
        click_on '登録する'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        expect(page).to have_content '新しいタスクを作成しました！'
        expect(page).to have_content 'Test Name'
        expect(page).to have_content 'Test Description'
        expect(page).to have_content '2021/11/10 18:15'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test_name_01'
        expect(page).to have_content 'test_description_01'
        expect(page).to have_content '2023/04/18 10:35'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        expect(Task.order("created_at DESC").map(&:id))
      end
    end
    context '終了期限で並べ替えるリンクをクリックした場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it '終了期限が降順に並び替えられて表示される' do
        visit tasks_path
        click_on "終了期限で並べ替える"
        task_list = all('.expiration_date')
        expect(task_list[0]).to have_content '2025/01/22 07:42'
        expect(task_list[1]).to have_content '2023/04/18 10:35'
        expect(task_list[2]).to have_content '2021/12/27 21:10'
      end
    end
    context '優先順位で並び替えるリンクを押した場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it '優先順位の高い順に並び替えられて表示される' do
        visit tasks_path
        click_on "優先順位で並べ替える"
        task_list = all('.priority')
        expect(task_list[0]).to have_content '高'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it '該当タスクの内容が表示される' do
        visit tasks_path(:task)
        expect(page).to have_content 'test_name_01'
        expect(page).to have_content 'test_description_01'
        expect(page).to have_content '2023/04/18 10:35'
      end
    end
  end
  describe '検索機能' do
    # before do
      # 必要に応じて、テストデータの内容を変更して構わない
      # FactoryBot.create(:task, name: 'task01', status: '未着手')
      # FactoryBot.create(:second_task, name: 'task02', status: '着手中')
    # end
    context 'タイトルであいまい検索をした場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'search_name', with: 'test_name_01'
        click_on '検索'
        expect(page).to have_content 'test_name_01'
      end
    end
    context 'ステータス検索をした場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "未着手", from: 'search_status'
        click_on '検索'
        search = all('.status')
        expect(search[0].text).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'testuser@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
      end
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'search_name', with: '02'
        select "着手中", from: 'search_status'
        click_on '検索'
        expect(page).to have_content 'test_name_02'
        expect(page).to have_content '着手中'