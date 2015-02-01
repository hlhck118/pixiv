class PrivacyLevel < ActiveRecord::Base
  has_many :illustrations

  validates :name, presence: true, length: {maximum: 16}
end
