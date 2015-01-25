class Admin::PublishersController < ApplicationController
  before_action :get_publisher, only: [:show, :edit, :destroy, :update]

  def index
    @publishers = Publisher.all
  end

  def new
    @publisher = Publisher.new
  end

  def show

  end

  def edit

  end

  def destroy
    @publisher.destroy
    redirect_to admin_publishers_path
  end

  def update
    if @publisher.update_attributes(publisher_params)
      redirect_to admin_publisher_path(@publisher)
    else
      render :edit
    end
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.save
      redirect_to admin_publisher_path(@publisher)
    else
      render :new
    end
  end

  private

  def publisher_params
    params.require(:publisher).permit(:name, :country, :email, :phone)
  end

  def get_publisher
    @publisher = Publisher.find(params[:id])
  end

end
