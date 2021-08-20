class Task < ApplicationRecord
  validates :content, :title, presence: true
  scope :latest, -> { order(created_at: :desc) }
  scope :expired, -> { order(expiration_date: :desc) }
  scope :priority, -> { order(priority: :asc) }
  scope :search_title, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :search_status, -> (status) { where(status: status)}
  enum priority: [:高, :中, :低]
end
