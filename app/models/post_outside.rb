class PostOutside < ApplicationRecord
  belongs_to :post_summary
  
  validate :address, presence: true
  
end
