class Admin::BooksController < Admin::AdminController
  before_action :get_book, except: [:new, :create, :index]

  def new
    @book = Book.new
  end

  def index
    @q = Book.search(params[:q])
    @books = @q.result.page(params[:page]).per(5)
  end

  def edit

  end

  def show

  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_book_path(@book)
    else
      render :new
    end
  end

  def update
    if @book.update_attributes(book_params)
      redirect_to admin_book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit(:avatar, :title, :author_id, :publisher_id, :edition, :genre, :description)
  end

  def get_book
    @book = Book.find(params[:id])
  end
end
