require 'test_helper'

class UserUploadIllustrationTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryGirl.create(:user)
  end

  test "render sign in page when not sign in" do
    visit new_illustration_path
    has_content? "You need to sign in or sign up before continuing."
  end

  test "upload with invalid file type, not image" do
    login_as(@user, :scope => :user)
    visit new_illustration_path
    attach_file "illustration_image", File.join(Rails.root, "test", "fixtures", "test_doc.docx")
    fill_in "illustration_title", with: "Test Upload"
    click_button "Upload"
    has_content? "Image content type is invalid"
  end

  test "upload with valid image and not choose restriction" do
    login_as(@user, :scope => :user)
    visit new_illustration_path
    attach_file "illustration_image", File.join(Rails.root, "test", "fixtures", "test_img.jpg")
    fill_in "illustration_title", with: "Test Upload"
    choose "illustration_privacy_level_1", visible: false
    click_button "Upload"
    has_content? "Restriction can't be blank"
  end

  test "upload with valid image and not choose privacy_level" do
    login_as(@user, :scope => :user)
    visit new_illustration_path
    attach_file "illustration_image", File.join(Rails.root, "test", "fixtures", "test_img.jpg")
    fill_in "illustration_title", with: "Test Upload"
    choose "illustration_restriction_1"
    click_button "Upload"
    has_content? "Privacy level can't be blank"
  end

  test "upload with valid image" do
    login_as(@user, :scope => :user)
    visit new_illustration_path
    attach_file "illustration_image", File.join(Rails.root, "test", "fixtures", "test_img.jpg")
    fill_in "illustration_title", with: "Test Upload"
    choose "illustration_privacy_level_1"
    choose "illustration_restriction_1"
    click_button "Upload"
    has_content? "Illustration Uploaded!"
  end
end
