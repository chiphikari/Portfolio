class PostSummary < ApplicationRecord
  belongs_to :user
  has_one :post_house, dependent: :destroy
  accepts_nested_attributes_for :post_house

  has_one :post_outside, dependent: :destroy
  accepts_nested_attributes_for :post_outside

  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image, append: true

  enum category: {
    video: 0,
    book: 1,
    other: 2,
    place: 3,
    cafe: 4,
    walk: 5
  }

end
