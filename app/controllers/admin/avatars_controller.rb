class Admin::AvatarsController < ApplicationController
  before_action :get_avatar, except: [:new, :create, :index]

  def index
    @avatars = Avatar.all
  end

  def new
    @avatar = Avatar.new
  end

  def show

  end

  def create
    @avatar = Avatar.new(avatar_params)
    if @avatar.save
      redirect_to admin_avatar_path(@avatar)
    else
      render :new
    end
  end

  def edit

  end

  def destroy
    @avatar.destroy
    redirect_to admin_avatars_path
  end

  def update
    if @avatar.update_attributes(avatar_params)
      redirect_to admin_avatar_path(@avatar)
    else
      render :edit
    end
  end

  private

  def get_avatar
    @avatar = Avatar.find(params[:id])
  end

  def avatar_params
    params.require(:avatar).permit(:name, :user_id)
  end
end
