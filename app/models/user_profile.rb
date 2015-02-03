class UserProfile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar,
                    styles: {
                        small: "150x150!"
                    },
                    url: "/uploads/:attachment/:id/:style/:filename",
                    path: ":rails_root/public/uploads/:attachment/:id/:style/:filename"

  validates_attachment :avatar, presence: true,
                       content_type: {:content_type => /\Aimage\/(png|jpeg)\Z/},
                       size: {less_than: 2.megabytes}

  validate :image_dimensions
  validates :nickname, presence: true, length: {maximum: 16}
  validates :gender, :gender_public, :birthdate, :birthdate_public, presence: true
  private
  def image_dimensions
    return unless avatar?
    require_width = 300
    require_height = 300
    tmp_file = avatar.queued_for_write[:original]
    unless (tmp_file.nil? || errors.any?)
      dimentions = Paperclip::Geometry.from_file(tmp_file)
      errors.add(:avatar, "Width must be #{require_width}") unless dimentions.width <= require_width
      errors.add(:avatar, "Height must be #{require_height}") unless dimentions.height <= require_height
    end
  end
end
