class PostSummary < ApplicationRecord
  belongs_to :user
  belongs_to :post_house
end
