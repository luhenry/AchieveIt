class CreateAchievementSteps < ActiveRecord::Migration
  def change
    create_table :achievement_steps do |t|
      t.integer :id
      t.integer :achievement_id
      t.string :name
      t.string :slug
      t.integer :value

      t.timestamps
    end
  end
end
