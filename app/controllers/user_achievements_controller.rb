class UserAchievementsController < ApplicationController

  # GET /user_achievements/1
  # GET /user_achievements/1.json
  def show
    user        = User.find(params[:user_id])
    achievement = Achievement.find(params[:achievement_id])

    @user_achievement = UserAchievement.select('achievement_id, user_id, level').where(user_id: params[:user_id], achievement_id: params[:achievement_id]).first

    respond_to do |format|
      format.json { render json: @user_achievement }
    end
  end

  def increment
    user        = User.find(params[:user_id])
    achievement = Achievement.find(params[:achievement_id])

    user_achievement = UserAchievement.where(user_id: params[:user_id], achievement_id: params[:achievement_id]).first

    if not user_achievement
      user_achievement = UserAchievement.create
      user_achievement.user_id        = params[:user_id]
      user_achievement.achievement_id = params[:achievement_id]
      user_achievement.level          = 0
    end

    user_achievement.increment(:level).save

    respond_to do |format|
      format.json { render json: {message: 'success', user_id: user_achievement.user_id, achievement_id: user_achievement.achievement_id, level: user_achievement.level}}
    end
  end
end