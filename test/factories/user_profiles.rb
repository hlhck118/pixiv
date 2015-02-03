FactoryGirl.define do
  factory :user_profile do
    nickname "SolomonT"
    avatar { fixture_file_upload(Rails.root.join('test/fixtures/test_avatar.jpg'), 'image/jpeg') }
    gender true
    gender_public true
    birthdate Time.zone.now
    birthdate_public true

    association :user
  end
end
