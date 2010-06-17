require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures:users
  
  test "create user" do
    MyString = users(:one)
    assert_not_nil MyString
  end
end
