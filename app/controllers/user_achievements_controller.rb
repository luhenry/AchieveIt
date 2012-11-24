class UserAchievementsController < ApplicationController
  
  before_filter :authenticate_developer!

  def show
    user        = User.find(params[:user_id])
    achievement = Achievement.find(params[:achievement_id])

    user_achievement = UserAchievement.select('achievement_id, user_id, level').where(user_id: params[:user_id], achievement_id: params[:achievement_id]).first
    achievement_step = self.get_achievement_step(params[:achievement_id], user_achievement.level)

    respond_to do |format|
      format.json { render json: {user_id: user_achievement.user_id, achievement_id: user_achievement.achievement_id, level: user_achievement.level, step: achievement_step.name} }
    end
  end

  def increment
    user        = User.find(params[:user_id])
    achievement = Achievement.find(params[:achievement_id])

    level = Integer(params[:value]) rescue 1

    user_achievement = UserAchievement.find_or_create_by_user_id_and_achievement_id(params[:user_id], params[:achievement_id])
    user_achievement.increment(:level, level)
    user_achievement.save

    achievement_step = self.get_achievement_step(params[:achievement_id], user_achievement.level)

    respond_to do |format|
      format.json { render json: {message: 'success', user_id: user_achievement.user_id, achievement_id: user_achievement.achievement_id, level: user_achievement.level, step: achievement_step ? achievement_step.name : nil}}
    end
  end

  def set
    user        = User.find(params[:user_id])
    achievement = Achievement.find(params[:achievement_id])

    user_achievement = UserAchievement.find_or_create_by_user_id_and_achievement_id(params[:user_id], params[:achievement_id])
    user_achievement.level = params[:value] || 1
    user_achievement.save

    achievement_step = self.get_achievement_step(params[:achievement_id], user_achievement.level)

    respond_to do |format|
      format.json { render json: {message: 'success', user_id: user_achievement.user_id, achievement_id: user_achievement.achievement_id, level: user_achievement.level, step: achievement_step ? achievement_step.name : nil}}
    end
  end

  def get_achievement_step achievement_id, level
    return AchievementStep.select('name') \
            .where('achievement_id = :achievement_id AND value <= :value', {achievement_id: achievement_id, value: level}) \
            .order('value DESC') \
            .limit(1) \
            .first
  end
end