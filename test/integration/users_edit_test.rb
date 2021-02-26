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
end
