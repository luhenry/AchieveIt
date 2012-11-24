class ProjectsController < ApplicationController

  before_filter :authenticate_developer!

  def index
    projects = Project.select('projects.name, projects.slug').joins(:developers).where('developers.id = :id', {id: current_developer.id})

    respond_to do |format|
      format.json { render json: projects }
    end
  end

  def show
    project = self.get_project(params[:slug], current_developer.id)

    respond_to do |format|
      format.json { render json: project }
    end
  end

  def create
    project = Project.new(params[:project])

    respond_to do |format|
      if project.save
        project_developer = ProjectDeveloper.new(developer_id: current_developer.id, project_id: project.id)

        if project_developer.save
          format.json { render json: project, status: :created, location: project }
        else
          project.destroy
        end
      else
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    project = self.get_project(params[:slug], current_developer.id)

    respond_to do |format|
      if project.update_attributes(params[:project])
        format.json { head :no_content }
      else
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    project = self.get_project(params[:slug], current_developer.id)

    respond_to do |format|
      if project.destroy
        format.json { head :no_content }
      else
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end

  protected 

  def get_project project_slug, developer_id
    project = Project.select('projects.name, projects.slug') \
                .joins(:developers) \
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
end
