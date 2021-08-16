require 'rails_helper'
describe 'タスク管理機能', type: :model do 
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      # 1. new_task_pathに遷移する（新規作成ページに遷移する）
      # ここにnew_task_pathにvisitする処理を書く
      FactoryBot.create(:task, title: 'task')
      FactoryBot.create(:task, content: 'task2')

      visit tasks_path

      # 2. 新規登録内容を入力する
      #「タスク名」というラベル名の入力欄+「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容を入力する
      # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      expect(page).to have_content 'task'
      fill_in "task[content]", with: 'あいう'
      expect(page).to have_content 'あいう'


      # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
      # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く

      # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
      # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
    end
  end
end