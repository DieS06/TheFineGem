class Hotel < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  before_validation :set_default_rating, on: :create
  has_many :rooms, dependent: :destroy
  has_many :reservations, through: :rooms, dependent: :destroy
  has_many :comments, through: :rooms, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true,
  length: { minimum: 10, maximum: 100 }
  validates :phone, presence: true,
  format: { with: /\A[+\d]?(?:[\d\-.\s]{7,}\z)/,
  message: "must be a valid phone number" }
  validates :email, presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid phone number" }
  validates :description, presence: true,
  length: { minimum: 10, maximum: 600 }
  validates :user_id, presence: true
  validates :rooms_ids, presence: false
  validates :rating, presence: false,  numericality: { greater_than_or_equal_to: 0,
   less_than_or_equal_to: 5 }

  def calculate_rating
    total_comments = comments.count
    total_rate = comments.sum(:rate)
    return 0 if total_comments.zero?

    average_rate = total_rate / total_comments.to_f

    self.rating = [ [ average_rate, 0 ].max, 5 ].min.round(2)
    save
  end

  private
  def set_default_rating
    self.rating ||= 0
  end
end
