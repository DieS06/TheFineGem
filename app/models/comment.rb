class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :body, presence: true
  validates :status, presence: true
end
