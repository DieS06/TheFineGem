class Role < ApplicationRecord
  belongs_to :user
  validates :role_label, presence: true
  validates :status, presence: true
end
