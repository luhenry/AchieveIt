class UserAchievementsController < ApplicationController
  
  before_filter :authenticate_developer!

  before_filter do |controller|
    @user = User.find(params[:user_id])
  end

  def get_user
    @user_achievements = UserAchievement.find_by_user_id(@user.id)
    @achievement_steps = AchievementStep.where(achievement_id: @user_achievements.map { |e| e.achievement_id })

    respond_to do |format|
      format.html
      format.json { render json: {
        user_id: @user.id,
        achievements: @user_achievements.map { |e|  }
      }}
    end
  end

  def get_user_achievement
    @achievement      = Achievement.find_by_slug(params[:achievement_slug])
    @user_achievement = UserAchievement.find_by_achievement_id(@achievement.id)
    @achievement_step = self.get_achievement_step(@achievement.id, user_achievement.level)

    respond_to do |format|
      format.html
      format.json { render json: {
        user_id:          @user.id, 
        achievement_slug: @achievement.slug, 
        level:            @user_achievement.level, 
        step:             @achievement_step ? @achievement_step.name : nil
      }}
    end
  end

  def set
    level = Integer(params[:value]) rescue 1

    @achievement      = Achievement.find_by_slug(params[:achievement_slug])
    @user_achievement = UserAchievement.find_by_achievement_id(@achievement.id)
    @achievement_step = self.get_achievement_step(@achievement.id, user_achievement.level)
    
    user_achievement.level = level
    user_achievement.save

    achievement_step = self.get_achievement_step(params[:achievement_id], user_achievement.level)

    respond_to do |format|
      format.json { render json: {
        message:        'success', 
        user_id:        @user.id, 
        achievement_id: @achievement.slug, 
        level:          @user_achievement.level, 
        step:           @achievement_step ? @achievement_step.name : nil
      }}
    end
  end

  def increment
    level = Integer(params[:value]) rescue 1

    @achievement      = Achievement.find_by_slug(params[:achievement_slug])
    @user_achievement = UserAchievement.find_by_achievement_id(@achievement.id)
    @achievement_step = self.get_achievement_step(@achievement.id, user_achievement.level)

    user_achievement.increment(:level, level)
    user_achievement.save

    achievement_step = self.get_achievement_step(params[:achievement_id], user_achievement.level)

    respond_to do |format|
      format.json { render json: {
        message:        'success', 
        user_id:        @user.id, 
        achievement_id: @achievement.slug, 
        level:          @user_achievement.level, 
        step:           @achievement_step ? @achievement_step.name : nil
      }}
    end
  end

  protected

  def get_achievement_step achievement_id, level
    return AchievementStep.select('name') \
            .where('achievement_id = :achievement_id AND value <= :value', {achievement_id: achievement_id, value: level}) \
            .order('value DESC') \
            .limit(1) \
            .first
  end
end