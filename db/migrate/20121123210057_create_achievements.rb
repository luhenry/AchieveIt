class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :id
      t.integer :project_id
      t.string :name
      t.string :slug
      t.string :image

      t.timestamps
    end
  end
end
