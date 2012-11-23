class UserAchievement < ActiveRecord::Base
  attr_accessible :achievement_id, :level, :user_id

  belongs_to :achievement
  belongs_to :user
end
