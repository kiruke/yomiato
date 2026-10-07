class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :pre_review, presence: true, length: { maximum: 800 }
  validates :post_review, length: { maximum: 1600 }
  validates :book_id, uniqueness: { scope: :user_id }
end
