class BooksController < ApplicationController
  before_action :get_book, only: [:show]

  def index
    @q = Book.search(params[:q])
    @books = @q.result.page(params[:page]).per(5)
  end

  def show
    @comment = Comment.new
  end

  private

  def get_book
    @book = Book.find(params[:id])
  end

end
