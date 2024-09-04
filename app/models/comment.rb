class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :body, presence: true
  validates :status, presence: true

  def comment_detail
    "User: #{user.full_name}\n" +
    "Room: #{room.name}\n" +
    "Rate: #{rate}\n" +
    "Comment: #{body}\n" +
    "Status: #{status}\n"
  end
end
