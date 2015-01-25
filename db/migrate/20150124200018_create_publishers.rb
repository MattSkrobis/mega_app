class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :country
    end
  end
end
