class Task < ApplicationRecord
  belongs_to :user
  validates :content, :title, presence: true
  scope :latest, -> { order(created_at: :desc) }
  scope :expired, -> { order(expiration_date: :desc) }
  scope :priority, -> { order(priority: :asc) }
  
# モデル名.where('カラム名 like ?','%検索したい文字列%')文字列のどの部分にでも検索したい文字列が含まれていればOK
  scope :search_title, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :search_status, -> (status) { where(status: status)}
  enum priority: [:高, :中, :低]
end
