FactoryGirl.define do
  factory :privacy_level do
    name "Public"
    factory :privacy_level_pixiv do
      name "My pixiv"
    end

    factory :privacy_level_private do
      name "Private"
    end
  end
end
