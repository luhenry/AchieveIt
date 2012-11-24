class AchievementStep < ActiveRecord::Base
  attr_accessible :achievement_id, :value, :name, :slug

  belongs_to :achievement
end
