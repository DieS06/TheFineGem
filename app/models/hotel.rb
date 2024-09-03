class Hotel < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :address, presence: true
end
