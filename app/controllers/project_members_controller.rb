class ProjectMembersController < ApplicationController
  before_action :set_project_member, only: [:show, :edit, :update, :destroy]

  # GET /project_members
  # GET /project_members.json
  def index
    @project_members = []
  end

  # GET /project_members/1
  # GET /project_members/1.json
  def show
  end

  # GET /project_members/new
  def new
    @project_member = ProjectMember.new
  end

  # GET /project_members/1/edit
  def edit
  end

  # POST /project_members
  # POST /project_members.json
  def create
    @project_member = ProjectMember.new(project_member_params)
    @project = @project_member.project

    respond_to do |format|
      if @project_member.save
        format.json { render :show, status: :created, location: project_project_member_url(@project, @project_member) }
      else
        format.json { render json: @project_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_members/1
  # PATCH/PUT /project_members/1.json
  def update
    respond_to do |format|
      if @project_member.update(project_member_params)
        format.json { render :show, status: :ok, location: project_project_member_url(@project, @project_member) }
      else
        format.json { render json: @project_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_members/1
  # DELETE /project_members/1.json
  def destroy
    @project_member.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_member
      @project_member = ProjectMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_member_params
      params.require(:project_member).permit(:role_id, :project_id, :person_id)
    end
end
