require File.dirname(__FILE__) + '/../test_helper'

require 'test/unit'

class BookTest < ActiveSupport::TestCase
	
  fixtures :books
	
  def test_empty_attributes 
  	book = Book.new
	  	assert !book.valid?  #also validates that publish_year is set to zero
	  	assert book.errors.invalid?(:title)
	  	assert book.errors.invalid?(:author_first)
	  	assert book.errors.invalid?(:author_last)
	  	assert book.errors.invalid?(:category_id)
  end
  
  def test_publish_year_number
  	book = Book.new
  	book.title = "ABC"
  	book.author_first = "ABC"
  	book.author_last = "ABC"
  	book.publish_year = "Two thousand ten"
  	book.category_id = 1
  		assert !book.valid?
  end
  
  def test_unique_title
  	book = Book.new(:title        => books(:rails_book_1).title,
  					:author_first => "ABC",
  					:author_last  => "ABC",
  					:publish_year => 2010,
  					:category_id  => 1)
  		assert !book.save
  end
  
  def test_fav_exists
  	@user = User.find(:first)
  	@book = Book.find(:first)
  	@user.favorite_added(@book)
  		assert_equal true, @user.favorite_exists?(@book)
  end
  
  def test_add_to_favs
  	@user = User.find(:first)
  	@book = Book.find(:first)
  	@user.favorite_added(@book)
	  	assert_equal 1, @user.books.count
	  	assert_equal 1, @book.users.count
	  	assert_equal @user.id.to_s, @user.books.find(:first).user_id
  		assert_equal @book.id.to_s, @book.users.find(:first).book_id
  end
  
  def test_del_from_favs
  	test_add_to_favs
  	@user.favorite_deleted(@book)
	  	assert_equal 0, @user.books.count
	  	assert_equal 0, @book.users.count
  end
  
  def test_index_choices
  	@user1 = users(:casoler)
  	@user2 = users(:cmrodriguez)
  	@book1 = books(:rails_book_1)
  	@book2 = books(:rails_book_2)
  	@book3 = books(:ruby_book)
  	@user1.favorite_added(@book1)
  	@user1.favorite_added(@book2)
  	@user1.favorite_added(@book3)
  	@user2.favorite_added(@book2)
	  	assert_equal 4, Book.find(:all).size #all books
	  	assert_equal 1, @user2.books.find(:all).size #my books
  	books = Book.find(:all, :conditions => ['user_id != ?', @user2.id], :joins => :users, :group => "title")
  		assert_equal 3, books.size #other books
  end
  	
end
