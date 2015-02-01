require 'test_helper'

class UserDeleteIllustrationTest < ActionDispatch::IntegrationTest
  def setup
    @illustration = FactoryGirl.create(:illustration)
    login_as(@illustration.user, :scope => :user)
    visit illustration_path(@illustration)
  end

  test "redirect to sign in page when not signed in" do
    logout(:user)
    has_content? "You need to sign in or sign up before continuing."
  end

  test "delete image successful" do
    click_link "Delete"
    has_content? "Illustration deleted!"
  end

end
