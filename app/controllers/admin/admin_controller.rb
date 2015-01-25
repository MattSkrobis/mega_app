class Admin::AdminController < ApplicationController
  before_action :authenticate_user!, :current_user_is_admin?

  private

  def current_user_is_admin?
    unless current_user.admin?
      flash[:error] = 'You are not an admin!'
      redirect_to root_path
    end
  end
end
