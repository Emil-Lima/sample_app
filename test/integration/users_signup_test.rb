require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  'Good Name',
                                         email: 'user@invalid',
                                         password:              'notmach',
                                         password_confirmation: 'NOTMATCH' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Jane James',
                                        email: 'valid@email.com',
                                        password: 'validpassword',
                                        password_confirmation: 'validpassword' } }
    end
    follow_redirect!
    assert_template 'users/show'
    refute flash.empty?
    assert_select 'div.alert-success'
    assert is_logged_in?
  end
end
