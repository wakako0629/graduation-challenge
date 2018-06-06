class Blog < ApplicationRecord
  belongs_to :user,optional: true
  validates :title, :content, presence: true
  validates :content, length: { in: 1..140 }
  
  mount_uploader :image,ImageUploader
  
end
