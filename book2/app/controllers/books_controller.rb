class BooksController < ApplicationController  

#	require 'will_paginate'	
	
  	before_filter :authorize_access
  	before_filter :get_user_info
  	
	# GET /books
	# GET /books.xml
	def index
		@choice = params[:choice]
	
		case @choice
			when "mine"
				books = @user.books.find(:all, :order => 'title')
			when "others"
				books = Book.find(:all, :conditions => ['user_id != ?', @user.id], :joins => :users, :group => "title", :order => "title")
			else
				books = Book.find(:all, :order => "title")
		end

		@books = books.paginate :page => params[:page], :per_page => 10

		respond_to do |format|
			format.html # index.html.erb
		end
	end

	# GET /books/1
	# GET /books/1.xml
	def show
		@book = Book.find(params[:id])
		@in_favs = @user.favorite_exists?(@book)
		
		respond_to do |format|
			format.html # show.html.erb
		end
	end

	# GET /books/new
	# GET /books/new.xml
	def new
		@book = Book.new
		@all_categories = get_all_categories
	
		respond_to do |format|
			format.html # new.html.erb
		end
	end

	# POST /books
	# POST /books.xml
	def create
		@book = Book.new(params[:book])
		@book.title = @book.title.titleize
		@book.author_first = @book.author_first.titleize
		@book.author_last = @book.author_last.titleize
		@all_categories = get_all_categories
	
		respond_to do |format|
			if @book.save
				flash[:notice] = 'Book was successfully created.'
				format.html { redirect_to(:action => 'index', :choice => ' ') }
			else
				flash[:notice] = 'Book was not created.  Please try again.'
				format.html { render :action => "new" }
			end
		end
	end

	def add_to_favs
		@book = Book.find(params[:id])

		if @user.favorite_added(@book)
			flash[:notice] = 'Book was successfully added to your collection.'
			redirect_to(:action => 'index', :choice => 'mine')
		else 
			flash[:notice] = 'Book was not added to your collection.  Please try again.'
			redirect_to(@book)
		end
	end

	def delete_from_favs
		@book = Book.find(params[:id])
		
		if @user.favorite_deleted(@book)
			flash[:notice] = 'Book was successfully deleted from your collection.'
		else 
			flash[:notice] = 'Book was not deleted from your collection.  Please try again.'
		end
		
		redirect_to(:action => 'index', :choice => 'mine')
	end
	
  # ----------------------------------------------------------
  
  private
  
  def get_user_info
    @user = User.find(session[:user_id])
  end
  
  def get_all_categories
  	return @all_categories = Category.find(:all, :order => 'name ASC').collect {|category| [category.name, category.id]}
  end

end
