class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.integer :id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_hash

      t.timestamps
    end
  end
end
