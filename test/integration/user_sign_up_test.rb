require 'test_helper'

class UserSignUpTest < ActionDispatch::IntegrationTest

  test "user sign up with blank information" do
    visit new_user_registration_url
    click_button "Sign Up"
    has_content? "can't be blank", count: 3
  end

  test "user sign up with correct information" do
    visit new_user_registration_url
    fill_in "user_email", with: "testabc@gmail.com"
    fill_in "user_password", with: "12345678"
    fill_in "user_password_confirmation", with: "12345678"
    click_button "Sign Up"
    assert_equal root_url, current_url
    has_content? "signed successfully"
  end
end
