class PostOutside < ApplicationRecord
  belongs_to :post_summary

  geocoded_by :address
  after_validation :geocode

  validates :address, presence: true
end
