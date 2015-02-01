require 'test_helper'

class UserEditIllustrationTest < ActionDispatch::IntegrationTest
  def setup
    Warden.test_reset!
    @restriction = FactoryGirl.create(:restriction)
    @privacy_level = FactoryGirl.create(:privacy_level)
    @illustration = FactoryGirl.create(:illustration)
    login_as(@illustration.user, :scope => :user)
    visit edit_illustration_path(@illustration)
  end

  test "redirect when not signed in" do
    logout(:user)
    has_content? "You need to sign in or sign up before continuing."
  end

  test "update with invalid file type, not image" do
    attach_file "illustration_image", File.join(Rails.root, "test", "fixtures", "test_doc.docx")
    fill_in "illustration_title", with: "Test Upload"
    click_button "Update"
    has_content? "Image content type is invalid"
  end

  test "update with valid image and not choose restriction" do
    attach_file "illustration_image", File.join(Rails.root, "test", "fixtures", "test_img.jpg")
    fill_in "illustration_title", with: "Test Upload"
    choose "illustration_privacy_level_id_#{@privacy_level.id}"
    click_button "Update"
    has_content? "Restriction can't be blank"
  end

  test "update with valid image and not choose privacy_level" do
    attach_file "illustration_image", File.join(Rails.root, "test", "fixtures", "test_img.jpg")
    fill_in "illustration_title", with: "Test Upload"
    choose "illustration_restriction_id_#{@restriction.id}"
    click_button "Update"
    has_content? "Privacy level can't be blank"
  end

  test "update with valid image" do
    attach_file "illustration_image", File.join(Rails.root, "test", "fixtures", "test_img.jpg")
    fill_in "illustration_title", with: "Test Upload"
    choose "illustration_privacy_level_id_#{@privacy_level.id}"
    choose "illustration_restriction_id_#{@restriction.id}"
    click_button "Update"
    has_content? "Illustration Updated!"
  end
end
