require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example)
  end
  
  test 'invalid edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", 
                                              email: "invalid@invalid,com", 
                                              password: "password", 
                                              password_confirmation: "invalid" } }
    assert_template 'users/edit'
    assert_select 'div', 'The form contains 3 errors'
  end

  test 'valid edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "New Name"
    email = "thisvalid@email.com"
    patch user_path(@user), params: { user: { name: name, email: email, password: "", password_confirmation: "" } }
    refute flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
