class BooksController < ApplicationController
  before_action :get_book, only: [:show]

  def index
    @books = Book.all.order(:title).page params[:page]
  end

  def show
    @comment = Comment.new
  end

  private

  def get_book
    @book = Book.find(params[:id])
  end

end
