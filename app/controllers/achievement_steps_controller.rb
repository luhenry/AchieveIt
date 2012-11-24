class AchievementStepsController < ApplicationController

  before_filter :authenticate_developer!

  def index
    @project           = self.get_project(params[:project_slug], current_developer.id)
    achievement_steps = AchievementStep.select('achievement_steps.achievement_id, achievement_steps.name, achievement_steps.slug, achievement_steps.value') \
                          .joins(:achievement) \
                          .where('achievements.project_id = :project_id AND achievements.slug = :achievement_slug', {project_id: @project.id, achievement_slug: params[:achievement_slug]})

    respond_to do |format|
      format.html
      format.json { render json: achievement_steps }
    end
  end

  def show
    @project          = self.get_project(params[:project_slug], current_developer.id)
    @achievement_step = self.get_achievement_step(@project.id, params[:achievement_slug], params[:slug])

    respond_to do |format|
      format.html
      format.json { render json: @achievement_step }
    end
  end

  def new
    achievement = Achievement.find_by_achievement_slug(params[:achievement_slug])

    @project          = self.get_project(params[:project_slug], current_developer.id)
    @achievement_step = AchievementStep.new(achievement_id: achievement.id)

    respond_to do |format|
      format.html
    end
  end

  def create
    @project          = self.get_project(params[:project_slug], current_developer.id)
    @achievement_step = AchievementStep.new(params[:achievement_step])

    respond_to do |format|
      if @achievement_step.save
        format.html { redirect_to @achievement_step, notice: 'Achievement step was successfully created.' }
        format.json { render json: @achievement_step, status: :created, location: @achievement_step }
      else
        format.html { render action: "new" }
        format.json { render json: @achievement_step.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @project          = self.get_project(params[:project_slug], current_developer.id)
    @achievement_step = self.get_achievement_step(@project.id, params[:achievement_slug], params[:slug])

    respond_to do |format|
      format.html
    end
  end

  def update
    @project          = self.get_project(params[:project_slug], current_developer.id)
    @achievement_step = self.get_achievement_step(@project.id, params[:achievement_slug], params[:slug])

    respond_to do |format|
      if @achievement_step.update_attributes(params[:achievement_step])
        format.html { redirect_to @achievement_step, notice: 'Achievement step was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @achievement_step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = self.get_project(params[:project_slug], current_developer.id)

    @achievement_step = self.get_achievement_step(@project.id, params[:achievement_slug], params[:slug])
    @achievement_step.destroy

    respond_to do |format|
      format.html { redirect_to achievement_steps_url }
      format.json { head :no_content }
    end
  end

  protected

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

  def get_achievement_step project_id, achievement_slug, achievement_step_slug
    achievement_step = AchievementStep.select('achievement_steps.achievement_id, achievement_steps.name, achievement_steps.slug, achievement_steps.value') \
                        .joins(:achievement) \
                        .where(
                          'achievements.project_id = :project_id AND achievements.slug = :achievement_slug AND achievement_steps.slug = :achievement_step_slug', {
                            project_id:            project_id,
                            achievement_slug:      achievement_slug,
                            achievement_step_slug: achievement_step_slug
                          }) \
                        .limit(1).first

    if not achievement_step
      raise ActionController::RoutingError.new("Step does not exist")
    end

    return achievement_step
  end
end
