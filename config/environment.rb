# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# disable Rails default field_with_errors
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end