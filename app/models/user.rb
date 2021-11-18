class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, uniqueness: true
  validates :user_name, length: { in: 2..20 }
  # validates :zipcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}　→　Google API学んでから検討

  scope :only_status, -> { where(status: true) }
  attachment :profile_image
  has_many :post_summaries, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def active_for_authentication?
    super && (status == true)
  end
end
