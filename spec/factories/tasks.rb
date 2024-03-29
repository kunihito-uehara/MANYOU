FactoryBot.define do #step4
    factory :task do
      title { 'ファースト' }
      content { 'ファースト' }
      expiration_date { '2022/01/01' }
      status{ '未着手' }
      priority {'高'}
      association :user
    end

    factory :second_task, class: Task do
      title { 'セカンド' }
      content { 'セカンド' }
      expiration_date { '2022/01/02' }
      status{ '着手中' }
      priority {'中'}
      association :user, factory: :admin_user
    end

    factory :third_task, class: Task do
      ttitle { 'サード' }
      content { 'サード' }
      expiration_date { '2022/01/03' }
      status{ '完了' }
      priority {'低'}
      association :user
    end
end
