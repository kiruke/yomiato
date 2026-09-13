require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "User can be created with valid attributes" do
    user = User.new(
      username: "テスト",
      email: "test@gmail.com",
      password: "password",
      password_confirmation: "password"
    )

    assert user.valid?
  end

  test "User is invalid when username is blank" do
    user = User.new(
      username: "",
      email: "test@gmail.com",
      password: "password",
      password_confirmation: "password"
    )

    assert_not user.valid?
  end

  test "User is invalid when password is less than 3 characters" do
    user = User.new(
      username: "test",
      email: "test@gmail.com",
      password: "ab",
      password_confirmation: "ab"
    )

    assert_not user.valid?
  end
  
  test "User is invalid when password confirmation is blank" do
    user = User.new(
      username: "test",
      email: "test@gmail.com",
      password: "password",
      password_confirmation: ""
    )

    assert_not user.valid?
  end

  test "User is invalid when email is blank" do
    user = User.new(
      username: "test",
      email: "",
      password: "password",
      password_confirmation: "password"
    )

    assert_not user.valid?
  end

  test "User is invalid when email is duplicated" do
    user = User.create(
      username: "test",
      email: "test@gmail.com",
      password: "password",
      password_confirmation: "password"
    )

    assert user.persisted?

    another_user = User.new(
      username: "test2",
      email: "test@gmail.com",
      password: "password",
      password_confirmation: "password"
    )

    assert_not another_user.valid?
  end

  test "User is invalid when password confirmation does not match" do
    user = User.new(
      username: "テスト",
      email: "test@gmail.com",
      password: "password",
      password_confirmation: "passw0rd"
    )

    assert_not user.valid?
  end
end
