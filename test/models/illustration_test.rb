require 'test_helper'

class IllustrationTest < ActiveSupport::TestCase
  def setup
    @illustration = FactoryGirl.build(:illustration)
  end

  test "illustration should be valid" do
    assert @illustration.valid?
  end

  test "illustration image should be present" do
    @illustration.image = nil
    assert_not @illustration.valid?
  end

  test "illustration image should only accept image" do
    illustration_doc =FactoryGirl.build(:illustration_doc)
    assert_not illustration_doc.valid?
  end

  test "title should be present" do
    @illustration.title = nil
    assert_not @illustration.valid?
  end

  test "title should not longer than 50 characters" do
    @illustration.title = "a"*51
    assert_not @illustration.valid?
  end

end
