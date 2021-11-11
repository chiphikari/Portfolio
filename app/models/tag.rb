class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :post_summaries, through: :post_tags

end