class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :body, presence: true
  validates :rate, presence: true
  validates :status, presence: true
end
