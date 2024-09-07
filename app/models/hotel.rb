class Hotel < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :rooms, dependent: :destroy
  has_many :reservations, through: :rooms, dependent: :destroy
  has_many :comments, through: :rooms, dependent: :destroy
  has_many_attached :images
  paginates_per 2

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
  validates :rating, numericality: { greater_than_or_equal_to: 0,
   less_than_or_equal_to: 5 }

  def calculate_rating
    total_comments = comments.rate.count
    return 0 if total_comments.zero?

    total_rate = comments.sum(:rate)
    average_rate = total_rate / total_comments.to_f

    self.rating = [ [ average_rate, 0 ].max, 5 ].min.round(2)
    save
  end
end
