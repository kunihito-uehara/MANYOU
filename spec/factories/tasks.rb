FactoryBot.define do
    factory :task do
      # 下記の内容は実際に作成するカラム名に合わせて変更してください
      #title { 'test_title' }
      content { 'test_content' }
    end

    factory :second_task, class: Task do
      content { 'second_task_content' }
    end

    factory :third_task, class: Task do
      content { 'third_task_content' }
    end

    factory :fourth_task, class: Task do
      content { 'fourth_task_content' }
    end
end
