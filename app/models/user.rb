class User < ApplicationRecord
  has_many :hotels
  has_many :payments
  has_many :reserve_rooms
  has_many :rooms, through: :reserve_rooms
  has_many :comments

  enum role: { guest: 0, client: 1, admin: 2 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true,
  length: { minimum: 1, maximum: 70 }
  validates :last_name, presence: true,
  length: { minimum: 1, maximum: 70 }
  validates :phone, presence: true,
  format: { with: /\A[+\d]?(?:[\d\-.\s]{7,}\z)/,
  message: "must be a valid phone number" }
  validates :id_number, presence: true
  validates :email, presence: true, uniqueness: true,
  format: { with: URI::MailTo::EMAIL_REGEXP,
  message: "must be a valid phone number" }
  validates :password, presence: true
  validates :role, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
