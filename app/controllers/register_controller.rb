class RegisterController < ApplicationController
  def index
    @users = User.all
    render json: @users 
  end
  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user 
    else
      render json: @user.errors, status: :unprocessable_entity 
    end
end
  def user_params
      params.require(:register).permit(:name ,:email, :password, :password_confirmation)
    end
    
end