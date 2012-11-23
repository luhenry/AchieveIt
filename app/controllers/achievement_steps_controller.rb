class AchievementStepsController < ApplicationController
  # GET /achievement_steps
  # GET /achievement_steps.json
  def index
    @achievement_steps = AchievementStep.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @achievement_steps }
    end
  end

  # GET /achievement_steps/1
  # GET /achievement_steps/1.json
  def show
    @achievement_step = AchievementStep.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @achievement_step }
    end
  end

  # GET /achievement_steps/new
  # GET /achievement_steps/new.json
  def new
    @achievement_step = AchievementStep.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @achievement_step }
    end
  end

  # GET /achievement_steps/1/edit
  def edit
    @achievement_step = AchievementStep.find(params[:id])
  end

  # POST /achievement_steps
  # POST /achievement_steps.json
  def create
    @achievement_step = AchievementStep.new(params[:achievement_step])

    respond_to do |format|
      if @achievement_step.save
        format.json { render json: @achievement_step, status: :created, location: @achievement_step }
      else
        format.json { render json: @achievement_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /achievement_steps/1
  # PUT /achievement_steps/1.json
  def update
    @achievement_step = AchievementStep.find(params[:id])

    respond_to do |format|
      if @achievement_step.update_attributes(params[:achievement_step])
        format.json { head :no_content }
      else
        format.json { render json: @achievement_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /achievement_steps/1
  # DELETE /achievement_steps/1.json
  def destroy
    @achievement_step = AchievementStep.find(params[:id])
    @achievement_step.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
