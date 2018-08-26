require 'test_helper'
#this is extra execise that tests the full title helper which is 
#running from the ApplicationHelper in test_helper.rb
class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do 
		assert_equal full_title, "Ruby on Rails Tutorial Sample App"
		assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
	end
end		