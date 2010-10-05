require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def test_should_log_in
  	casoler = users(:casoler)
  	post :login, :username => casoler.username, :password => casoler.password
	  	assert_redirected_to :controller => "books", :action => "index", :choice => " "
	  	assert_equal casoler.id, session[:user_id]
	  	assert_equal "Welcome, #{casoler.first_name}!", flash[:notice]
  end
  
   def test_should_be_bad_login
  	casoler = users(:casoler)
  	post :login, :username => casoler.username, :password => 'nogood'
  		assert_template "login"
  end
  
  def test_should_get_new
    get :new
    	assert_response :success
  end

  def test_should_create_user
    assert_difference('User.count') do
      post :create, :user => {:username => "Bandit", :password => "secret", :first_name => "Bandit" }
    end
    assert_redirected_to :controller => "books", :action => "index", :choice => " "
  end
  
  def test_should_log_out
  	test_should_log_in
  	get :logout
	  	assert_nil(session[:user_id])
	  	assert_redirected_to :action => "login"
  end

end
  
 