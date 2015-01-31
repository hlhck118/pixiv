class Illustration < ActiveRecord::Base

  belongs_to :user

  before_create :rename_image_file
  before_save :extract_resolutions

  has_attached_file :image,
                    :styles => {
                        :big => "1280x720>",
                        :medium => "600x600>",
                        :thumb_md => "150x150>",
                        :thumb_sm => "100x100>"
                    },
                    :url => "/uploads/:attachment/:id/:style/:filename",
                    :path => ":rails_root/public/uploads/:attachment/:id/:style/:filename"

  validates_attachment :image,
                       :presence => true,
                       :content_type => {:content_type => /\Aimage\/.*\Z/},
                       :size => {:less_than => 10.megabytes}

  validates :title, presence: true, length: {maximum: 50}

  def rename_image_file
    extension = File.extname(image_file_name).downcase
    self.image.instance_write(:file_name, "pixiv_#{Time.now.to_i}#{extension}")
  end

  def extract_resolutions
    return unless image?
    tempfile = image.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.image_width = geometry.width.to_i
      self.image_height = geometry.height.to_i
    end
  end
end
