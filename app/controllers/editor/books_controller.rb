class Editor::BooksController < ApplicationController
  before_action :get_book, except: [:new, :index, :create]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def show

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
    params.require(:book).permit(:title, :author, :publisher, :edition, :genre, :description)
  end
end
