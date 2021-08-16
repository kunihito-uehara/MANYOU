class Task < ApplicationRecord
  validates :content, :title, presence: true

end
