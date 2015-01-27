class Admin::CommentsController < Admin::AdminController
  before_action :get_comment, except: [:new, :create, :index]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to admin_comment_path(@comment)
    else
      render :new
    end
  end

  def index
    @q = Comment.search(params[:q])
    @comments = @q.result.page(params[:page]).per(10)
  end

  def destroy
    @comment.destroy
    redirect_to admin_comments_path
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to admin_comment_path(@comment)
    else
      render :edit
    end
  end

  def edit

  end

  def show

  end

  private

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:rating, :description, :user_id, :book_id)
  end
end
