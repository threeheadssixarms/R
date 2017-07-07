class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id,
    presence: true
  validates :content,
    presence: true,
    length: {maximum: Settings.max_content_length}
  validate :picture_size

  scope :most_recent, ->{order created_at: :desc}
  scope :available, -> user do
    where "user_id IN (?) OR user_id = ?", user.following_ids, user.id
  end

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > Settings.max_image_size.megabytes
      errors.add :picture, I18n.t("image_size_limit")
    end
  end
end
