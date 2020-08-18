class Video < ApplicationRecord
  mount_uploader :video_image, VideoImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :lists, dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :video_image, presence: { message: 'を選択してください' }
end
