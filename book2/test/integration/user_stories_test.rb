require 'test_helper'

class UserStoriesTest < ActionController::IntegrationTest
  fixtures :all

  # 1. Valid user logs in;
  # 2. logs out.
  test "User logs in, then logs out" do
  	# 1.
  	casoler = users(:casoler)
  	login(casoler)
  		assert_response :found
  		assert_equal casoler.id, session[:user_id]
  		assert_equal "Welcome, #{casoler.first_name}!", flash[:notice]
  		assert_redirected_to :controller => "books", :action => "index", :choice => " "
  	# 2.
  	logout
  		assert_response :found
  		assert_equal nil, session[:user_id]
  		assert_equal "You are logged out.  Come back soon!", flash[:notice]
  end
  
  # 1. New user creates an ID;
  # 2. logs out.
  test "New user creates ID" do  	
  	# 1.
	  	post "/users", :user => {:username => "Bandit", :password => "secret", :first_name => "Bandit" }
	  		assert_redirected_to :controller => "books", :action => "index", :choice => " "
	  		assert_equal "Welcome, Bandit!", flash[:notice]
  	# 2.
	  	logout
	  		assert_response :found
	  		assert_equal nil, session[:user_id]
	  		assert_equal "You are logged out.  Come back soon!", flash[:notice]
  end 
  
  # 1. Valid user logs in;
  # 2. adds book to general collection; 
  # 3. adds a book from the general collection to her favorites list; and
  # 4. deletes book from her favorites list.
  test "user logs in, adds book, deletes book" do
  	# 1.
	  	casoler = users(:casoler)
	  	login(casoler)
  	# 2.
	  	post "/books", :book => {:title => "the girl with the dragon tattoo", :author_last => "larsson", :author_first => "stieg", :publish_year => 2008, :category_id => 4}
	  	book = Book.find_by_author_last("Larsson")
	  		assert_equal book.title, "The Girl With The Dragon Tattoo"
	  		
	 	books = Book.find(:all)
	  		assert_equal 5, books.count
  	# 3.
	  	post "/books/add_to_favs/242507676"
	  		assert_equal casoler.books.count, 1
	  		assert_redirected_to :controller => "books", :action => "index", :choice => "mine"
  	# 4.	
	  	post "/books/delete_from_favs/242507676"
	  		assert_equal casoler.books.count, 0
	  		assert_redirected_to :controller => "books", :action => "index", :choice => "mine"
  end
  
  # 1. Valid user logs in;
  # 2. views list of others' favorites;
  # 3. adds book from that list to her favorites.
  test "user logs in, view other's favorites, adds book to favorites" do
  	# set up test by adding book to another user's favorite list
  	cmrodriguez = users(:cmrodriguez)
	login(cmrodriguez)
	
  	post "/books/add_to_favs/242507676"
  		assert_equal cmrodriguez.books.count, 1
  	
  	logout #user cmrodriguez
  	
  	# 1. 
	  	casoler = users(:casoler)
	  	login(casoler)
  	
	# 2.
	  	get "/books?choice=others"  #go to others' favorites screen
	  		assert :success
	  		assert_equal cmrodriguez.books[0], books(:rails_book_2) #verify that first user's book is in her favorite's list
  	# 3.
	  	post "/books/add_to_favs/242507676"  #now add that person's book to my favorites list
	  		assert_equal casoler.books.count, 1
	  		assert_equal cmrodriguez.books.count, 1
	  		assert_equal casoler.books[0].title,  cmrodriguez.books[0].title
	  		assert_redirected_to :controller => "books", :action => "index", :choice => "mine"
  end
  	
  private
  #------------------------------------------------------
  
  def login(user)
  	post "/users/login", :username => user.username, :password => user.password
  end
  	
  def logout
  	post "/users/logout"
  end
  
end