require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
	
  fixtures :users
  fixtures :books
  
  def test_empty_attributes 
  	user = User.new
  	assert !user.valid?
  	assert user.errors.invalid?(:username)
  	assert user.errors.invalid?(:password)
  	assert user.errors.invalid?(:first_name)
  end
  
  def test_unique_user
  	user = User.new(:username   => users(:casoler).username,
  					:password   => "noogie",
  					:first_name => "Carolina")
  	assert !user.save
  #	assert_equal I18n.translate('activerecord.errors.messages.taken'), user.errors.on(:username)
  end  	
  
end
