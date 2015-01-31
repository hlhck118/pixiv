require 'test_helper'

class UserSignInTest < ActionDispatch::IntegrationTest

  test "sign in with blank information" do
    visit new_user_session_url
    click_button "Sign In"
    has_content? "Invalid email or password"
    assert_match new_user_session_url, current_url
  end

  test "sign in with wrong email and password" do
    visit new_user_session_url
    fill_in "user_email", with: "abcqwe@gmail.com"
    fill_in "user_password", with: "asdf"
    has_content? "Invalid email or password"
    assert_match new_user_session_url, current_url
  end

  test "sign in with corrent email and password" do
    visit new_user_session_url
    fill_in "user_email", with: "usertest1@gmail.com"
    fill_in "user_password", with: "12345678"
    assert_match root_url, current_url
    has_content? "Signed in successfully"
  end
end
