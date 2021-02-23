require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
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
    @user.save
    assert_not @duplicate_user.valid?
  end

  test "email with a different letter case should still violate uniqueness" do
    @duplicate_user = @user.dup
    @duplicate_user.email = @duplicate_user.email.upcase
    @user.save
    assert_not @duplicate_user.valid?
  end
end
