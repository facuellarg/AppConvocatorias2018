class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :update, :destroy ]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = current_user
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end
  
  def social
       # puts params
    @user = User.find_by(email: social_params[:email])
    
    if @user == nil
        p = Faker::Internet.password(8)
        @user = User.new(email: social_params[:email],name: social_params[:given_name],lastname: social_params[:family_name],
          password: p, password_confirmation: p,dependence_id: social_params[:dependence_id])
          
        if @user.save!
            render json: @user
        else
           render json:{}, status: 404
        end
    else
        knock_token = Knock::AuthToken.new payload: { sub: @user.id }
        render json: knock_token
    end
  end

  # POST /users
  def create
    
    @user = User.new(user_params)

    if @user.save
      @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name ,:lastname,:level, :email, :password, :password_confirmation, :dependence_id)
    end
    
    def social_params
      params.permit(:email,:given_name,:family_name,:dependence_id)
    end
end
