class Achievement < ActiveRecord::Base
  attr_accessible :image, :name, :slug, :project_id

  has_many :achievement_steps
  has_many :users, :through => :user_achievements

  belongs_to :project
end
