require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example)
  end

  test 'invalid log in' do
    get login_path
    assert_template 'new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'new'
    refute flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'valid log in' do
    get login_path
    assert_template 'new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 1
    assert_select 'a[href=?]', user_path(@user), count: 1
  end 
end
