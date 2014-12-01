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
        if @project.start_date
          post_new_project_to_yammer
        end
        format.html { redirect_to @board, notice: @project.name + ' was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        update_dates if !@project.initiative.standing?
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
      #if project start date changes, then change the start dates for the people
      if @project.previous_changes.has_key? "start_date"
        @project.project_members.each do |pm|
          pm.update_attributes(:start_date => @project.start_date)
        end
      end
      #if project end date changes, then change the end dates for the people
      if @project.previous_changes.has_key? "end_date"
        @project.project_members.each do |pm|
          pm.update_attributes(:end_date => @project.end_date)
        end
      end
      #if project has a start date now but previously did not, then post to yammer about a new project starting
      if @project.previous_changes.has_key?("start_date") && @project.previous_changes["start_date"][0].nil?
        post_new_project_to_yammer
      end
    end

    def post_new_project_to_yammer
      #only post to yammer if it's a Product or Internal Project
      if !["Support/Other"].include?(@project.project_type) && @board.id && !@project.initiative.standing?
        #if project gets a start date and start date was previously nil, then post to yammer about a new project
        yamr = Yammer::Client.new(:access_token  => current_user.access_token)
        permalinks_to_alert = []
        people_to_alert = Person.where(:new_project_alert => [@project.project_type, "All"], :board => @board).where.not(:permalink => nil)
        people_to_alert.each do |p|
          permalinks_to_alert.push("@"+p.permalink) if !p.new_project_alert.blank?
        end

        yamr.create_message("A new project called '" + @project.name + "' in the " + @project.initiative.name + " initiative has been \
          added to the bigboard with a kickoff date of " + @project.start_date.strftime("%B %d, %Y") + ". Go check it out! " + edit_board_project_url(@board, @project) + " \n\n Courtesy \
          mentions: " + permalinks_to_alert.join(", "), :group_id => @board.group_id_for_yammer_post)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :start_date, :end_date, :completed, :retro, :status, :location, :location_id, :project_type, :initiative_id, :board_id, :notes, :tech_spec, :product_spec, :retrospective, :yammer_group, :experiment_key, :project_description)
    end

end
