require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  #goal: test that user does not create when there are errors on form
  #how? By ensuring thar user count in db remains same (does not increase)
  test "invalid info on user sign-up form does not create a user" do
    get signup_path
    before_count = User.count
    
    post users_path, params: { user: {  name: "",
                                        email: "user@invalid",
                                        password: "lame",
                                        password_confirmation: "male"} }
                                        
    after_count = User.count
    assert_equal before_count, after_count
  end
  
  test "idiomatically preferred version of invalid info on user sign-up form does not create a user" do
    get signup_path
    
    assert_no_difference "User.count" do
        post users_path, params: { user: {  name: "",
                                            email: "user@invalid",
                                            password: "lame",
                                            password_confirmation: "male"} }
    end
    #confirm that the sign up form renders again
    assert_template "users/new"
  end
  
  test "alert appears on the form when there are errors" do
    get signup_path
    
    post users_path, params: { user: {  name: "",
                                        email: "user@invalid",
                                        password: "lame",
                                        password_confirmation: "male"} }
    
    assert_template "users/new"
    assert_select "div.alert", {count: 1, text: "Oops, there were errors on this page. 4 errors to be exact:" }
    assert_select "div.alert-danger"
  end
  
  test "message(s) appears on the form describing failed validations when there are errors" do
    get signup_path
    
    post users_path, params: { user: {  name: "",
                                        email: "user@invalid",
                                        password: "lame",
                                        password_confirmation: "male"} }
    
    assert_template "users/new"
    assert_select "#error_explanation"
    assert_select "li", "Name can't be blank"
    assert_select "li", "Password confirmation doesn't match Password"
    assert_select "li", "Password is too short (minimum is 6 characters)"
  end
  
  test "error fields are styled differently when there are errors" do
    get signup_path
    
    post users_path, params: { user: {  name: "",
                                        email: "user@invalid",
                                        password: "lame",
                                        password_confirmation: "male"} }
    
    assert_select "div.field_with_errors"
  end
  
  
  #goal: test successful user sign-up
  test "User count increases by 1 upon successful signup" do
    get signup_path
    
    assert_difference "User.count", 1 do
      
      post users_path, params: { user: {  name: "Michael Hartl",
                                          email: "example@railstutorial.org",
                                          password: "password",
                                          password_confirmation: "password"} }
                                       
    end
  end
  
  test "Show page or user profile page shows upon successful signup" do
    get signup_path
    
    post users_path, params: { user: {  name: "Michael Hartl",
                                        email: "example@railstutorial.org",
                                        password: "password",
                                        password_confirmation: "password"} }
                                     
    
    follow_redirect!
    assert_template "users/show"
  end
  
  test "success message (flash) shows in user profile page spun up on successful signup" do
    get signup_path
    
    post users_path, params: { user: {  name: "Michael Hartl",
                                        email: "example@railstutorial.org",
                                        password: "password",
                                        password_confirmation: "password"} }
                                        
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    assert_select "div.alert-success", {count: 1, text: "Welcome to the Sample App!"}
  end
end
