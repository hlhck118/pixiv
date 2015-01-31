require 'test_helper'
include ActionDispatch::TestProcess

class IllustrationTest < ActiveSupport::TestCase
  def setup
    @user = FactoryGirl.create(:user)
    @illustration = FactoryGirl.create(:illustration, :user => @user)
  end

  test "illustration should be valid" do
    assert @illustration.valid?
  end

  test "illustration image should be present" do
    @illustration.image = nil
    assert_not @illustration.valid?
  end

  test "illustration image should only accept image" do
    @illustration.image = fixture_file_upload('test_doc.docx',
                                              'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
    assert_not @illustration.valid?
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
