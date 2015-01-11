class Editor::CommentsController < ApplicationController
  before_action :get_comment, only: [:edit, :update, :delete]

  def edit

  end

  def update

    if @comment.update_attributes(comment_params)
      redirect_to editor_book_path(@book)
    else
      render "editor/books/show"
    end
  end

  def delete
    @comment.destroy
    redirect_to editor_book_path(@book)
  end

  private

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:rating, :description, :user_id, :book_id)
  end
end
