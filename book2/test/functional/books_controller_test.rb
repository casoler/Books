require File.dirname(__FILE__) + '/../test_helper'

class BooksControllerTest < ActionController::TestCase
  def test_should_get_login_screen
  	get :action => "index"
	  	assert_redirected_to :controller => "users", :action => "login"
	  	assert_equal "Please log in.", flash[:notice]
  end
  
  def test_should_get_index
    get :index, {}, {:user_id => users(:casoler).id}
	    assert_response :success
	    assert_not_nil assigns(:books)
  end

  def test_should_get_new
  	get :index, {}, {:user_id => users(:casoler).id}
    get :new
    	assert_response :success
  end

  def test_should_create_book
  	get :index, {}, {:user_id => users(:casoler).id}
	    assert_difference('Book.count') do
	      post :create, :book => {:title => "Loving Frank", :author_first => "Nancy", :author_last => "Horan", :publish_year => 2007, :category_id => 592789234}
	    end
	    assert_redirected_to :controller => 'books', :action => 'index', :choice => ' '
  end

  def test_should_show_book
  	get :index, {}, {:user_id => users(:casoler).id}
    get :show, :id => books(:rails_book_1).id
    	assert_response :success
  end

end
