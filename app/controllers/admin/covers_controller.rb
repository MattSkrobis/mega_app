class Admin::CoversController < ApplicationController
  before_action :get_cover, except: [:new, :create, :index]

  def index
    @covers = Cover.all
  end

  def edit

  end

  def new
    @cover = Cover.new
  end

  def show

  end

  def update
    if @cover.update_attributes(cover_params)
      redirect_to admin_cover_path(@cover)
    else
      render :edit
    end
  end

  def destroy
    @cover.destroy
    redirect_to admin_covers_path
  end

  def create
    @cover = Cover.new(cover_params)
    if @cover.save
      redirect_to admin_cover_path(@cover)
    else
      render :new
    end
  end

  private

  def get_cover
    @cover = Cover.find(params[:id])
  end

  def cover_params
    params.require(:cover).permit(:name, :book_id)
  end
end
