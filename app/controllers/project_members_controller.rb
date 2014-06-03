class ProjectMembersController < ApplicationController
  before_action :set_project, only: [:index, :new, :create]
  before_action :set_project_member, only: [:show, :edit, :update, :destroy]
  before_action :set_board

  # GET /project_members
  # GET /project_members.json
  def index
    @project_members = @project.project_members
  end

  # GET /project_members/1
  # GET /project_members/1.json
  def show
  end

  # GET /project_members/new
  def new
    @project_member = @project.project_members.build
  end

  # GET /project_members/1/edit
  def edit
  end

  # POST /project_members
  # POST /project_members.json
  def create
    @project_member = @project.project_members.build(project_member_params)
    if @project_member.start_date.nil?
      @project_member.start_date = Date.today
    end

    respond_to do |format|
      if @project_member.save
        format.html { redirect_to board_url(@project_member.project.initiative.board), notice: @project_member.person.name + ' successfully added to ' + @project_member.project.name + '.' }
        format.json { render :show, status: :created, location: project_member_url(@project, @project_member) }
      else
        format.html { redirect_to :new }
        format.json { render json: @project_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_members/1
  # PATCH/PUT /project_members/1.json
  def update
    respond_to do |format|
      if @project_member.update(project_member_params)
        format.html { redirect_to board_url(@project_member.project.initiative.board), notice: @project_member.person.name + ' on ' + @project_member.project.name + ' updated.' }
        format.json { render :show, status: :ok, location: project_member_url(@project_member) }
      else
        format.html { render :edit }
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
      @board = @project_member.project.initiative.board
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_board
      @board = @project.nil? ? @project_member.project.initiative.board : @project.initiative.board
      @show_boards_nav = !@board.nil? && !@board.new_record?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_member_params
      params.require(:project_member).permit(:role_id, :project_id, :person_id, :start_date, :end_date, :uid)
    end
end
