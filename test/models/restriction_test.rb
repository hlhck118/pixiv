require 'test_helper'

class RestrictionTest < ActiveSupport::TestCase
  def setup
    @restriction = FactoryGirl.create(:restriction)
  end

  test "Restriction should be valid" do
    assert @restriction.valid?
  end

  test "Restiction name should be present" do
    @restriction.name = nil
    assert_not @restriction.valid?
  end

  test "Restriction name should not longer than 16 characters" do
    @restriction.name = "a"*17
    assert_not @restriction.valid?
  end
end
