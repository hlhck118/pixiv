require 'test_helper'

class PrivacyLevelTest < ActiveSupport::TestCase
  def setup
    @privacy_level = FactoryGirl.create(:privacy_level)
  end

  test "privacy level should be valid" do
    assert @privacy_level.valid?
  end

  test "privacy level name should be present" do
    @privacy_level.name = nil
    assert_not @privacy_level.valid?
  end

  test "privacy level name should not longer than 16 characters" do
    @privacy_level.name = "a"*17
    assert_not @privacy_level.valid?
  end
end
