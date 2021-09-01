class Task < ApplicationRecord
  belongs_to :user, optional: true #belongs_toの外部キーのnilを許可
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  validates :content, :title, presence: true
  scope :latest, -> { reorder(created_at: :desc) }
  scope :expired, -> { reorder(expiration_date: :desc) }
  scope :priority, -> { reorder(priority: :asc) }
  
# モデル名.where('カラム名 like ?','%検索したい文字列%')文字列のどの部分にでも検索したい文字列が含まれていればOK
  scope :search_title, -> (title) { where("title LIKE ?", "%#{title}%") }

  scope :search_status, -> (status) { where(status: status)}

  scope :search_labels, -> (label_id) {
    task_ids = Labeling.where(label_id: label_id).pluck(:task_id)
    where(id: task_ids)
  }
  enum status: {未着手:0, 着手中:1, 完了:2}
  enum priority: {高:0, 中:1, 低:2}
end
