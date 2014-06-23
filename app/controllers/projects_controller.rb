class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:create, :show, :new, :edit, :update]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    initiative = Initiative.find_by_id(project_params[:initiative_id])
    if initiative.nil?
      @project = Project.new(project_params)
    else
      @project = initiative.projects.build(project_params)
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to @board, notice: @project.name + ' was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end

    yamr = Yammer::Client.new(:access_token  => current_user.access_token)
    permalinks_to_alert = []
    if @project.project_type != "" #if project_type is Internal Projects or Product
      people_to_alert = Person.where(:new_project_alert => [@project.project_type, "All"]).where.not(:permalink => nil)
      people_to_alert.each do |p|
        permalinks_to_alert.push("@"+p.permalink)
      end
    end

    #currently posts to test group until pull request
    logger.debug "wtf"
    logger.debug permalinks_to_alert
    yamr.create_message("A new project called '" + @project.name + "' in the " + @project.initiative.name + " initiative has been added to the bigboard. This means \
     it will be staffed and kicked off soon. Go check it out! " + board_url(@board) + " \n\n Courtesy \
     mentions: " + permalinks_to_alert.join(", "), :group_id => 3716357)

  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        update_dates
        format.html { redirect_to @board, notice: @project.name + ' was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def set_board
      @board = Board.find(params[:board_id])
      @initiatives = @board.ongoing_initiatives
      @show_boards_nav = !@board.nil? && !@board.new_record?
    end

    def update_dates
      if @project.previous_changes.has_key? "start_date"
        @project.project_members.each do |pm|
          if pm.start_date.nil? || pm.start_date < @project.start_date
            pm.update_attributes(:start_date => @project.start_date)
          end
        end
      end
      if @project.previous_changes.has_key? "end_date"
        @project.project_members.each do |pm|
          if pm.end_date.nil? || pm.end_date == @project.previous_changes['end_date'][0]
            pm.update_attributes(:end_date => @project.end_date)
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :start_date, :end_date, :completed, :retro, :status, :location, :project_type, :initiative_id, :board_id)
    end
end
