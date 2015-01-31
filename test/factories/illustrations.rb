include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :illustration do
    image { fixture_file_upload(Rails.root.join('test/fixtures/test_img.jpg'), 'image/jpeg') }
    title "test img"
    description "aaaaaaaaaaaaaa"
    association :user
    factory :illustration_doc do
      image { fixture_file_upload(Rails.root.join('test/fixtures/test_doc.docx'),
                                  'application/vnd.openxmlformats-officedocument.wordprocessingml.document') }
      association :user_2
    end
  end
end