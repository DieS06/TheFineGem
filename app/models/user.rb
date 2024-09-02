class User < ApplicationRecord
  has_one :role

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
end
