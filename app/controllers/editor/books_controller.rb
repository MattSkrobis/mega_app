class Editor::BooksController < Editor::EditorController
  before_action :get_book, except: [:new, :index, :create]

  def index
    @q = Book.search(params[:q])
    @books = @q.result.page(params[:page]).per(5)
  end

  def new
    @book = Book.new
  end

  def show
    @comment = Comment.new
  end

  def edit

  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to editor_book_path(@book)
    else
      render :new
    end
  end

  def update
    if @book.update_attributes(book_params)
      redirect_to editor_book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to editor_books_path
  end

  private

  def get_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:avatar, :title, :author_id, :publisher_id, :edition, :genre, :description)
  end
end
