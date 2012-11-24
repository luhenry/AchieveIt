class AchievementStepsController < ApplicationController

  before_filter :authenticate_developer!

  def index
    project           = self.get_project    
    achievement_steps = AchievementStep.select('achievement_steps.achievement_id, achievement_steps.name, achievement_steps.slug, achievement_steps.value') \
      .joins(:achievement) \
      .where(
        'achievements.project_id = :project_id AND achievements.slug = :achievement_slug', {
          project_id:       project.id,
          achievement_slug: params[:achievement_slug]
        })

    respond_to do |format|
      format.json { render json: achievement_steps }
    end
  end

  def show
    project          = self.get_project    
    achievement_step = AchievementStep.select('achievement_steps.achievement_id, achievement_steps.name, achievement_steps.slug, achievement_steps.value') \
                        .joins(:achievement) \
                        .where(
                          'achievements.project_id = :project_id AND achievements.slug = :achievement_slug AND achievement_steps.slug = :achievement_step_slug', {
                            project_id:            project.id,
                            achievement_slug:      params[:achievement_slug],
                            achievement_step_slug: params[:slug]
                          }) \
                        .limit(1).first

    raise ActionController::RoutingError.new("Step does not exist") if not achievement_step

    respond_to do |format|
      format.json { render json: achievement_step }
    end
  end

  def create
    project          = self.get_project
    achievement_step = AchievementStep.new(params[:achievement_step])

    respond_to do |format|
      if achievement_step.save
        format.json { render json: achievement_step, status: :created, location: achievement_step }
      else
        format.json { render json: achievement_step.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    project          = self.get_project    
    achievement_step = AchievementStep.joins(:achievement) \
                        .where(
                          'achievements.project_id = :project_id AND achievements.slug = :achievement_slug AND achievement_steps.slug = :achievement_step_slug', {
                            project_id:            project.id,
                            achievement_slug:      params[:achievement_slug],
                            achievement_step_slug: params[:slug]
                          }) \
                        .limit(1).first

    respond_to do |format|
      if achievement_step.update_attributes(params[:achievement_step])
        format.json { head :no_content }
      else
        format.json { render json: achievement_step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    project          = self.get_project
    achievement_step = AchievementStep.joins(:achievement) \
                        .where(
                          'achievements.project_id = :project_id AND achievements.slug = :achievement_slug AND achievement_steps.slug = :achievement_step_slug', {
                            project_id:            project.id,
                            achievement_slug:      params[:achievement_slug],
                            achievement_step_slug: params[:slug]
                          }) \
                        .limit(1).first

    if not achievement_step
      raise ActionController::RoutingError.new("Step does not exist")
    else
      achievement_step.destroy
    end

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def get_project
    project = Project.joins(:developers) \
                .where(
                  'projects.slug = :project_slug AND developers.id = :developer_id', {
                    project_slug: params[:project_slug],
                    developer_id: current_developer.id
                  }) \
                .limit(1).first

    if not project
      raise ActionController::RoutingError.new("Project does not exist")
    end

    return project
  end
end
