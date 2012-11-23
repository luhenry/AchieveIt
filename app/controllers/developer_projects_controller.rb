class DeveloperProjectsController < ApplicationController
  # GET /developer_projects
  # GET /developer_projects.json
  def index
    @developer_projects = DeveloperProject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @developer_projects }
    end
  end

  # GET /developer_projects/1
  # GET /developer_projects/1.json
  def show
    @developer_project = DeveloperProject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @developer_project }
    end
  end

  # GET /developer_projects/new
  # GET /developer_projects/new.json
  def new
    @developer_project = DeveloperProject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @developer_project }
    end
  end

  # GET /developer_projects/1/edit
  def edit
    @developer_project = DeveloperProject.find(params[:id])
  end

  # POST /developer_projects
  # POST /developer_projects.json
  def create
    @developer_project = DeveloperProject.new(params[:developer_project])

    respond_to do |format|
      if @developer_project.save
        format.html { redirect_to @developer_project, notice: 'Developer project was successfully created.' }
        format.json { render json: @developer_project, status: :created, location: @developer_project }
      else
        format.html { render action: "new" }
        format.json { render json: @developer_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /developer_projects/1
  # PUT /developer_projects/1.json
  def update
    @developer_project = DeveloperProject.find(params[:id])

    respond_to do |format|
      if @developer_project.update_attributes(params[:developer_project])
        format.html { redirect_to @developer_project, notice: 'Developer project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @developer_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developer_projects/1
  # DELETE /developer_projects/1.json
  def destroy
    @developer_project = DeveloperProject.find(params[:id])
    @developer_project.destroy

    respond_to do |format|
      format.html { redirect_to developer_projects_url }
      format.json { head :no_content }
    end
  end
end
