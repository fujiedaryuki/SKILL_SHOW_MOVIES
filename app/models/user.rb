class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :last_name, :first_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_videos, through: :likes, source: :video


  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object.user_id
  end

  def like(video)
    like_videos << video
  end

  def notlike(video)
    like_videos.destroy(video)
  end

  def like?(video)
    like_videos.include?(video)
  end
 
end
