class AchievementsController < ApplicationController
  
  before_filter :authenticate_developer!

  def index
    project      = self.get_project(params[:project_slug], current_developer.id)
    achievements = Achievement.select('achievements.id, achievements.name, achievements.slug, achievements.image') \
                    .joins(:project) \
                    .where('projects.id = :project_id', {project_id: project.id})

    respond_to do |format|
      format.json { render json: achievements }
    end
  end

  def show
    project     = self.get_project(params[:project_slug], current_developer.id)
    achievement = self.get_achievement(params[:slug], project.id)

    respond_to do |format|
      format.json { render json: achievement }
    end
  end

  def create
    project     = self.get_project(params[:project_slug], current_developer.id)
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
    project     = self.get_project(params[:project_slug], current_developer.id)
    achievement = self.get_achievement(params[:slug], project.id)

    respond_to do |format|
      if achievement.update_attributes(params[:achievement])
        format.json { head :no_content }
      else
        format.json { render json: achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    project = self.get_project(params[:project_slug], current_developer.id)

    achievement = self.get_achievement(params[:slug], project.id)
    achievement.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def get_project project_slug, developer_id
    project = Project.joins(:developers) \
                .where(
                  'projects.slug = :project_slug AND developers.id = :developer_id', {
                    project_slug: project_slug,
                    developer_id: developer_id
                  }) \
                .limit(1).first

    if not project
      raise ActionController::RoutingError.new("Project does not exist")
    end

    return project
  end

  def get_achievement project_id, slug
    achievement = Achievement.joins(:project) \
                    .where(
                      'projects.id = :project_id AND achievements.slug = :slug', {
                        slug:       params[:slug],
                        project_id: project.id
                      }) \
                    .limit(1).first

    if not achievement
      raise ActionController::RoutingError.new("Achievement does not exist")
    end

    return achievement
  end
end
