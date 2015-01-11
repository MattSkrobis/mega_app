class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :rating
      t.integer :book_id
      t.integer :user_id
    end
  end
end
