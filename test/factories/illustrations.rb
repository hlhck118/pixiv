include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :illustration do
    image { fixture_file_upload(Rails.root.join('test/fixtures/test_img.jpg'), 'image/jpeg') }
    title "test img"
    description "aaaaaaaaaaaaaa"
    association :user
  end
end