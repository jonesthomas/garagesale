class Blog < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true, length: { maximum: 10000 }

end
