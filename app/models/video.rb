class Video < ApplicationRecord
  mount_uploader :video_image, VideoImageUploader
  belongs_to :user
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
end