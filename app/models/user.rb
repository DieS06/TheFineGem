class User < ApplicationRecord
  enum role: { guest: 0, user: 1, moderator: 2, propetary: 3, admin: 4 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :id_number, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :role, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
