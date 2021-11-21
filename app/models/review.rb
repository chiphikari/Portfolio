class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post_summary
  validates :score, presence: true
end
