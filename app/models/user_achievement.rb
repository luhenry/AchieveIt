class UserAchievement < ActiveRecord::Base
  attr_accessible :achievement_id, :level, :user_id
end
