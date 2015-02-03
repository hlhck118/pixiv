require 'test_helper'
include ActionDispatch::TestProcess

class UserProfileTest < ActiveSupport::TestCase
  def setup
    @user_profile = FactoryGirl.create(:user_profile)
  end

  test "user profile should be valid" do
    assert @user_profile.valid?
  end

  test "user nickname should be present" do
    @user_profile.nickname = nil
    assert_not @user_profile.valid?
  end

  test "user nickname should not longer than 16 characters" do
    @user_profile.nickname = "a"*17
    assert_not @user_profile.valid?
  end

  test "not accept avatar larger than 300x300" do
    @user_profile.avatar = fixture_file_upload('test_img.jpg','image/jpeg')
    assert_not @user_profile.valid?
  end

  test "not accept wrong image type of avatar" do
    @user_profile.avatar = fixture_file_upload('test_doc.docx',
                                               'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
    assert_not @user_profile.valid?
  end

  test "gender should be present" do
    @user_profile.gender = nil
    assert_not @user_profile.valid?
  end

  test "gender public should be present" do
    @user_profile.gender_public = nil
    assert_not @user_profile.valid?
  end

  test "birthdate should be present" do
    @user_profile.birthdate = nil
    assert_not @user_profile.valid?
  end

  test "birthdate_public should be present" do
    @user_profile.birthdate_public = nil
    assert_not @user_profile.valid?
  end

end
