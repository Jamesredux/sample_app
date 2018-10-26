require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
 def setup
 	@admin = users(:michael)
 	@non_admin = users(:archer)
 end

 test "index as admin including pagination and delete links" do 
 	log_in_as(@admin)
 	get users_path
 	assert_template 'users/index'
 	assert_select 'div.pagination'
 	first_page_of_users = User.paginate(page: 1)

 	first_page_of_users.each do |user|
 		assert_select 'a[href=?]', user_path(user), text: user.name 
 		unless user == @admin 
 			assert_select 'a[href=?]', user_path(user), text: 'delete'
 		end
 	end

 	assert_difference 'User.count', -1 do 
 		delete user_path(@non_admin)
 	end	
 end

 test "index as non-admin" do 
 	log_in_as(@non_admin)
 	get users_path
 	assert_select 'a', text: 'delete', count: 0
 end			

 
 test "can not view new user show page if account not activated" do 
   get signup_path 
   post users_path, params: { user: { name: "Example User", 
                                          email: "user@example.com", 
                                          password: "password", 
                                          password_confirmation: "password"} }
   user = assigns(:user)
   assert_not user.activated?
   user_id = user.id
   log_in_as(@non_admin)
   #when you try to access the users show page when they have not been activated
   # you should be redirected to the home page.
   get user_path user_id
   follow_redirect!
   assert_template 'static_pages/home'
  end 

#could not find a 2nd test that worked to check that users were not added to index until they are activated.
end

