class Hotel < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :reservations, through: :rooms
  has_many :comments, through: :rooms

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :address, presence: true
  validates :rooms_ids, absence: true
  validates :rating, presence: true

  def calculate_rating
    total_comments = comments.rate.count
    return 0 if total_comments.zero?

    total_rate = comments.sum(:rate)
    average_rate = total_rate / total_comments.to_f

    self.rating = [ [ average_rate, 0 ].max, 5 ].min.round(2)
    save
  end

  def hotel_detail
    "Name: #{name}\n" +
    "Address: #{address}\n" +
    "Phone: #{phone}" + "Email: #{email}\n" +
    "Rating: #{rating}\n" +
    "Description: #{description}\n"
  end
end
