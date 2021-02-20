require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  test 'invalid log in' do
    get login_path
    assert_template 'new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'new'
    refute flash.empty?
    get root_path
    assert flash.empty?
  end
end
