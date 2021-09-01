require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  #before do
  #   factory :user
  #     name { 'ユーザー1' }
  #     email { 'user1@dic.com' }
  #     password { '123456' }
  #     password_confirmation { '123456' }
  #     admin { false }

  #   factory :admin_user
  #     name { 'アドミン1' }
  #     email { 'admin1@dic.com' }
  #     password { '123456' }
  #     password_confirmation { '123456' }
  #     admin { true }

  # @user = FactoryBot.create(:user)
  # @admin_user = FactoryBot.create(:admin_user)
  # FactoryBot.create(:label)
    # FactoryBot.create(:second_label)
    # FactoryBot.create(:task, user: @user)
    # FactoryBot.create(:second_task, user: @user)
  #end
  describe 'ラベルの脱着機能' do
    context 'タスクの新規作成し、ラベルを選択した場合表示される' do
      before do
        FactoryBot.create(:user)
        FactoryBot.create(:admin_user)
        FactoryBot.create(:label)
        visit new_session_path
        fill_in 'session[email]', with: 'user1@dic.com'
        fill_in 'session[password]', with: '123456'
        click_on 'commit'
      end
      it '詳細画面で表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'タスク'
        fill_in 'task[content]', with: '内容'
        select "2022", from: 'task[expiration_date(1i)]'
        select "1月", from: 'task[expiration_date(2i)]'
        select "1", from: 'task[expiration_date(3i)]'
        select "未着手", from: 'task[status]'
        select "高", from: 'task[priority]'
        check "ラベル1"
        binding.irb
        click_on '登録する'
        click_on '詳細'
        expect(page).to have_content 'タスク'
        expect(page).to have_content '内容'
        expect(page).to have_content '1/1'
        expect(page).to have_content '0'
        expect(page).to have_content '高'
        expect(page).to have_content 'ラベル1'
     end
    end
    context "タスクの編集した時に選択したラベルが表示される" do
      before do
        FactoryBot.create(:user)
        FactoryBot.create(:admin_user)
        FactoryBot.create(:label)
        visit new_session_path
        fill_in 'session[email]', with: 'user1@dic.com'
        fill_in 'session[password]', with: '123456'
        click_on 'commit'
      end
      it '詳細画面で表示される' do
        all('.tasks_list')[0].click_on '編集'
        fill_in 'task[titile]', with: 'タイトル'
        fill_in 'task[content]', with: '内容'
        check "ラベル1"
        click_on '登録する'
        expect(page).to have_content 'ラベル1'
      end
    end
  end
    context 'ラベルの検索をした場合' do
      before do
        FactoryBot.create(:user)
        FactoryBot.create(:admin_user)
        FactoryBot.create(:label)
        visit new_session_path
        fill_in 'session[email]', with: 'user1@dic.com'
        fill_in 'session[password]', with: '123456'
        click_on 'commit'
      end
      it "検索したラベルが検索結果に表示される" do
        FactoryBot.create(:user)
        FactoryBot.create(:admin_user)
        FactoryBot.create(:label)
        visit new_task_path
        fill_in 'task[title]', with: 'ユーザー1'
        fill_in 'task[content]', with: '内容'
        check "ラベル1"
        click_on '登録する'
        visit tasks_path
        select 'LabelTest', from: :label_id
        click_on '検索'
        expect(page).to have_content 'LabelTest'
      end
    end
end