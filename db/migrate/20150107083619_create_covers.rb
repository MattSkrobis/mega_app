class CreateCovers < ActiveRecord::Migration
  def change
    create_table :covers do |t|
      t.string :name
      t.integer :book_id
    end
  end
end
