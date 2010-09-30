class UsersController < ApplicationController
  
  before_filter :reset_user
  
  def login
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      
      if user
        session[:user_id] = user.id
        flash[:notice] = "Welcome, #{user.first_name}!"
        redirect_to(:controller => 'books', :action=> 'index', :choice => ' ')
      else
        flash.now[:notice] = "Invalid username/password combination"
        render :action => 'login'
      end
    end
  end
  
  def logout
    flash[:notice] = "You are logged out.  Come back soon!"
    redirect_to(:action=> 'login')
  end
  
  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    if @user.save
      	 session[:user_id] = @user.id
         flash[:notice] = "Welcome, #{@user.first_name}!"
         redirect_to(:controller => 'books', :action=> 'index', :choice => ' ')
    else
    	flash[:notice] = "Error creating a new ID.  Please try again, or log in with your current ID."
        render :action => "new" 
    end
  end
  
  # -------------------------------------------------------------
  
  private
  
  def reset_user
    session[:user_id] = nil
  end

end
