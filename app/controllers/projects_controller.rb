class ProjectsController < ApplicationController
  before_filter :authenticate_developer!

  # GET /projects
  # GET /projects.json
  def index
    projects = Project.joins(:developers).where('developers.id = :id', {id: current_developer.id})

    respond_to do |format|
      format.json { render json: projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    project = Project.joins(:developers).where('developers.id = :developer_id AND projects.id = :project_id', {developer_id: current_developer.id, id: params[:id]})

    respond_to do |format|
      format.json { render json: project }
    end
  end

  # POST /projects
  # POST /projects.json
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

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    project = Project.joins(:developers).where('developers.id = :developer_id AND projects.id = :project_id', {developer_id: current_developer.id, id: params[:id]})

    respond_to do |format|
      if project.update_attributes(params[:project])
        format.json { head :no_content }
      else
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    project = Project.joins(:developers).where('developers.id = :developer_id AND projects.id = :project_id', {developer_id: current_developer.id, id: params[:id]})

    respond_to do |format|
      if project.destroy
        format.json { head :no_content }
      else
        format.json { render json: project.errors, status: :unprocessable_entity }
      end
    end
  end
end
