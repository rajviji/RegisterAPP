class UsersController < ApplicationController

 def index
    user_id = current_user.id
    @user_all = User.where(id: user_id)
  end

  def register
  	@user =  User.new
  end

  def login
    @user = 'login'
  end

  def create_user
  	@user = User.new(user_params)
  	if @user.save
		UserMailer.welcome_email(@user).deliver_later
  		flash[:notice] = 'Email has been sent. Please active your account'
  	else
  		flash[:alert] = @user.errors
  	end
  	redirect_to action: 'login'
  end

  def account_activation
   @user = User.find(params[:id])
  end

  def update_password
  	@user = User.find(params['user']['id'])
  	@user.active_status = true
  	@user.update(user_params)
  	redirect_to action: 'login'
  end

  def login_user
    @user = User.find_by(email: params["login"]["email"], password: params["login"]["password"])

    if @user.present? and @user.active_status == nil
      flash[:alert] = 'Please active your Account'
      render action: 'login'
    elsif @user.present? and @user.active_status == true
      flash[:alert] = 'Logged Successfully'
      session[:current_user_id] = @user.id  
      redirect_to action: 'index'
    else
      flash[:alert] = 'Invalid Email or Password'
      render action: 'login'
    end
  end

  def logout  
    session[:current_user_id] = nil  
    flash[:notice] = 'Logged out!'
    redirect_to action: 'login' 
  end  



  private

  def user_params
  	params.require(:user).permit( :id, :first_name, :last_name, :username, :email, :city, :password)
  end

end
