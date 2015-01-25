class Editor::EditorController < ApplicationController
  before_action :authenticate_user!, :current_user_is_editor?

  private

  def current_user_is_editor?
    unless current_user.editor?
      flash[:error] = 'You are not an editor!'
      redirect_to root_path
    end
  end
end
