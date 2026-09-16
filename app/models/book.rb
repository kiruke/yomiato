class Book < ApplicationRecord

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, length: { is: 13 }, allow_nil: true
end
