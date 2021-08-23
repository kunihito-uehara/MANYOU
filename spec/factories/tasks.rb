FactoryBot.define do
    factory :task do
      # 下記の内容は実際に作成するカラム名に合わせて変更してください
      title { 'ファースト' }
      content { 'ファースト' }
      expiration_date { '2022/01/01' }
      status{ '未着手' }
      priority {'高'}
    end

    factory :second_task, class: Task do
      title { 'セカンド' }
      content { 'セカンド' }
      expiration_date { '2022/01/02' }
      status{ '着手中' }
      priority {'中'}
    end

    factory :third_task, class: Task do
      ttitle { 'サード' }
      content { 'サード' }
      expiration_date { '2022/01/03' }
      status{ '完了' }
      priority {'低'}
    end
end
