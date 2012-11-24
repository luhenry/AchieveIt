class AchievementsController < ApplicationController
  
  before_filter :authenticate_developer!

  def index
    project = Project.joins(:developers) \
              .where(
                'developers.id = :developer_id AND projects.slug = :project_slug', {
                  developer_id: current_developer.id, 
                  project_slug: params[:project_slug]
                }) \
              .limit(1).first

    raise ActionController::RoutingError.new("Project does not exist") if not project
    
    achievements = Achievement.select('achievements.id, achievements.name, achievements.slug, achievements.image') \
                    .joins(:project) \
                    .where(
                      'projects.id = :project_id', {
                        project_id: project.id
                      }) \
                    .to_a

    respond_to do |format|
      format.json { render json: achievements }
    end
  end

  def show
    project = Project.joins(:developers) \
              .where(
                'developers.id = :developer_id AND projects.slug = :project_slug', {
                  developer_id: current_developer.id, 
                  project_slug: params[:project_slug]
                }) \
              .limit(1).first

    raise ActionController::RoutingError.new("Project does not exist") if not project
    
    achievement = Achievement.select('achievements.id, achievements.name, achievements.slug, achievements.image') \
                    .joins(:project) \
                    .where(
                      'projects.id = :project_id AND achievements.slug = :slug', {
                        slug:       params[:slug],
                        project_id: project.id
                      }) \
                    .limit(1).first

    raise ActionController::RoutingError.new("Achievement does not exist") if not achievement

    respond_to do |format|
      format.json { render json: achievement }
    end
  end

  def create
    raise ActionController::RoutingError.new("Project does not exist") \
      if not Project.joins(:developers) \
              .where(
                'developers.id = :developer_id AND projects.slug = :project_slug', {
                  developer_id: current_developer.id, 
                  project_slug: params[:project_slug]
                }) \
              .limit(1).first

    achievement = Achievement.new(params[:achievement])

    respond_to do |format|
      if achievement.save
        format.json { render json: achievement, status: :created, location: achievement }
      else
        format.json { render json: achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    project = Project.joins(:developers) \
              .where(
                'developers.id = :developer_id AND projects.slug = :project_slug', {
                  developer_id: current_developer.id, 
                  project_slug: params[:project_slug]
                }) \
              .limit(1).first

    raise ActionController::RoutingError.new("Project does not exist") if not project

    achievement = Achievement.joins(:project) \
                    .where(
                      'projects.id = :project_id AND achievements.slug = :slug', {
                        slug:       params[:slug],
                        project_id: project.id
                      }) \
                    .limit(1).first

    raise ActionController::RoutingError.new("Achievement does not exist") if not achievement

    respond_to do |format|
      if achievement.update_attributes(params[:achievement])
        format.json { head :no_content }
      else
        format.json { render json: achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    project = Project.joins(:developers) \
              .where(
                'developers.id = :developer_id AND projects.slug = :project_slug', {
                  developer_id: current_developer.id, 
                  project_slug:   params[:project_slug]
                }) \
              .limit(1).first

    raise ActionController::RoutingError.new("Project does not exist") if not project

    achievement = Achievement.joins(:project) \
                    .where(
                      'projects.id = :project_id AND achievements.slug = :slug', {
                        slug:       params[:slug],
                        project_id: project.id
                      }) \
                    .limit(1).first

    if not achievement
      raise ActionController::RoutingError.new("Achievement does not exist")
    else
      achievement.destroy
    end

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
