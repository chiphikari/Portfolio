class PostSummary < ApplicationRecord
  belongs_to :user
  has_one :post_house, dependent: :destroy
  has_one :post_outside, dependent: :destroy
  attachment :image

  enum category: {
    video: 0,
    book: 1,
    other: 2,
    place: 3,
    cafe: 4,
    walk: 5
  }
end
