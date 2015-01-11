class CommentsController < ApplicationController
  before_action :get_book
  before_action :get_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def create
    @comment = @book.comments.new(comment_params)
    if @comment.save
      redirect_to book_path(@book)
    else
      render 'books/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to book_path(@book)
  end

  private

  def get_book
    @book = Book.find(params[:book_id])
  end

  def get_comment
    @comment = @book.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:rating, :description, :user_id)
  end
end
