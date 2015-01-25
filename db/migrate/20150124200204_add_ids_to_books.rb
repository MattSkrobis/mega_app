class AddIdsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :author_id, :integer
    add_column :books, :publisher_id, :integer
    remove_column :books, :author
    remove_column :books, :publisher
  end
end
