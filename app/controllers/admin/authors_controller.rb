class Admin::AuthorsController < Admin::AdminController
  before_action :get_author, only: [:edit, :update, :destroy, :show]

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def show

  end

  def edit

  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to admin_author_path(@author)
    else
      render :new
    end
  end

  def update
    if @author.update_attributes(author_params)
      redirect_to admin_author_path(@author)
    else
      render :edit
    end
  end

  def destroy
    @author.destroy
    redirect_to admin_authors_path
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :age, :country)
  end

  def get_author
    @author = Author.find(params[:id])
  end
end
