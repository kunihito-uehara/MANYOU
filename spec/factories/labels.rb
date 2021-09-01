FactoryBot.define do
  factory :label do
    label_name { 'ラベル1' }
  end
  factory :second_label, class: Label do
    label_name{ 'ラベル2' }
  end
end
