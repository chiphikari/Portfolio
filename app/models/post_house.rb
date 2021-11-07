class PostHouse < ApplicationRecord
  belongs_to :post_summary

  validates :link, presence: true
  
end
