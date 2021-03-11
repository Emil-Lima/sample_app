require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "example@example.com", password: "examplepassword",
                    password_confirmation: "examplepassword")
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '   '
    refute @user.valid?
  end

  test 'email should be present' do
    @user.email = '        '
    refute @user.valid?
  end

  test 'name should be not too long' do
    @user.name = 'a' * 51
    refute @user.valid?
  end

  test 'email should be not too long' do
    @user.email = 'a' * 250 + 'example.com'
    refute @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[example@example.com other@this.org FOO@bar.com
                        A_bc-D@foo.bar.com u1+u2@foo.uk first.second@org.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation shoudl reject invalid addresses' do
    invalid_addresses = %w[example@example,com user_without_at.com user.user@org.
                        foo@bar_bar.com foo@bar+bar.com user@user..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      refute @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicated_user = @user.dup
    @user.save
    refute duplicated_user.valid?
  end

  test 'email should be all lower case' do
    example_email = 'ExamPlE@eXAMple.coM'
    @user.email = example_email
    @user.save
    assert_equal example_email.downcase, @user.reload.email
  end

  test 'password shoud be, at least, 8 char long' do
    @user.password = @user.password_confirmation = 'a' * 7
    refute @user.valid?
    @user.password = @user.password_confirmation = 'rytui3rb2A'
    assert @user.valid?
  end
  
    
  test 'authenticated? should return false for a user with nil digest' do
    refute @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
