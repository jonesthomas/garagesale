class Listing < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  validates :specific_location, presence: true
  validates :zip_code, presence: true
  validates :price, presence: true
  validates :details, presence: true
  validates :active, presence: true
end
