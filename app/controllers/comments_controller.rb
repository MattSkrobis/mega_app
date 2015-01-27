class CommentsController < ApplicationController
  before_action :user_signed_in?
  before_action :get_book
  before_action :get_comment, only: [:edit, :update, :destroy]
  before_action :correct_owner?, only: [:edit, :update, :destroy]
  before_action :first_comment_per_user_per_book?, only: :create

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
    @comment.user = current_user
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
    params.require(:comment).permit(:rating, :description)
  end

  def correct_owner?
    unless @comment.can_be_updated_or_deleted?(current_user)
      redirect_to book_path(@book), alert: 'You are not owner of this comment'
    end
  end

  def first_comment_per_user_per_book?
    if @book.user_has_comment?(current_user)
      redirect_to book_path(@book), alert: 'You cannot have more than one comment per book'
    end
  end
end
