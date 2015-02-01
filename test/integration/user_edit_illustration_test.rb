require 'test_helper'

class UserEditIllustrationTest < ActionDispatch::IntegrationTest
  def setup
    @illustration = FactoryGirl.create(:illustration)
    login_as(@illustration.user, :scope => :user)
    visit edit_illustration_path(@illustration)
  end

  test "redirect when not signed in" do
    logout(:user)
    has_content? "You need to sign in or sign up before continuing."
  end

  test ""
end
