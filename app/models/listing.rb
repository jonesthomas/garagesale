class Listing < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :specific_location, presence: true, length: { maximum: 30 }
	VALID_ZIPCODE_FORMAT = /\A\d{5}-\d{4}|\A\d{5}\z/
  validates :zip_code, presence: true, format: {with: VALID_ZIPCODE_FORMAT}
  validates :price, presence: true
  validates :details, presence: true, length: { maximum: 10000 }
  validates :active, presence: true
end


