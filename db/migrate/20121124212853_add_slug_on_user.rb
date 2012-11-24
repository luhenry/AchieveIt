class AddSlugOnUser < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :slug
    end
  end

  def down
    change_table :users do |t|
      t.remove :slug
    end
  end
end
