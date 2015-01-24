class Editor::CommentsController < ApplicationController
  before_action :get_book
  before_action :get_comment, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to editor_book_path(@book)
    else
      render "editor/books/show"
    end
  end

  def destroy
    @comment.destroy
    redirect_to editor_book_path(@book)
  end

  private

  def get_book
    @book = Book.find(params[:book_id])
  end

  def get_comment
    @comment = @book.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:rating, :description, :user_id, :book_id)
  end
end
