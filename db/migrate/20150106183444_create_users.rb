class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.integer :age
      t.string :country
    end
  end
end
