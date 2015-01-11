class Admin::UsersController < ApplicationController
  before_action :get_user, only: [:show, :destroy, :edit, :update]

  def show

  end

  def edit

  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :nickname, :age, :country, :email, :password, :password_confirmation)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
