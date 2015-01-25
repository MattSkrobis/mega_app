class AddCoversToBooks < ActiveRecord::Migration
  def change
    add_attachment :books, :avatar
  end
end
