require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "example",
                                                    password_confirmation: "example")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "valid email formats should be accepted" do
    emails = %w[ash@example.com ASH_KAR.AI@example.jp ash_kARAi@example.org.com]
    emails.each do |email|
      @user.email = email
      assert @user.valid?
    end
  end

  test "invalid email formats should be rejected" do
    emails = %w[ash ash2example ash.examplecom ash@exmple2.c0m ash@ex..com]
    emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should have been invalid"
    end
  end

  test "email should be unique" do
    @duplicate_user = @user.dup
     #save original user to db, then compare to duplicate user in memory
    @user.save
    assert_not @duplicate_user.valid?, "#{@duplicate_user.email.inspect} should have been invalid"
  end
  
  test "email saves as downcase" do
    mixed_case_email = "THaT@EXaMpLE.cOM"
    @user.email = mixed_case_email
    @user.save
    #test passes w/o needing reload but it's wiser to include it to avoid flakes
    assert_equal @user.reload.email, mixed_case_email.downcase
  end
  
  test "password and confirmed password should be present" do
    @user.password = @user.password_confirmation = ""
    assert_not @user.valid?, "password `#{@user.password.inspect}` should have been invalid"
  end
  
  test "password and confirmed password should not be too short" do
    @user.password = @user.password_confirmation = "9a$$W"
    assert_not @user.valid?, "password `#{@user.password.inspect}` should have been invalid"
  end
  
   
  test "password and confirmed password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?, "password `#{@user.password.inspect}` should have been invalid"
  end
end
