class Blog < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true, length: { maximum: 10000 }
  validates :author, presence: true, length: { maximum: 50 }

end
