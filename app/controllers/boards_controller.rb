class BoardsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :changelog, :allocation, :completed, :update, :destroy, :todo, :send_reminders]

  # GET /boards
  # GET /boards.json
  def index

    respond_to do |format|
      format.html { @boards = Board.where network_id: current_user.network_id }
      format.json { @boards = Board.where network_id: current_user.network_id }

    end
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)
    @board.network_id = current_user.network_id
    @board.user = current_user

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url }
      format.json { head :no_content }
    end
  end

  def allocation
    @teams = @board.teams.where(:single_project => true).order(:name)
    @initiatives = @board.initiatives.where(:completed => false)
    @allocations = {}
    @allocations[:total] = 0

    @initiatives.each do |i|
      @allocations[i] = {}
      @allocations[i][:total] = 0
      @allocations[i][:people] = {}
      @teams.each do |t|
        @allocations[i][:people][t] = []
      end
    end

    @teams.each do |t|
      t.people.each do |p|
        if p.active_project_count != 0
          person_initiative = p.active_projects.first.initiative
          if !person_initiative.completed
            @allocations[:total] += 1
            @allocations[person_initiative][:total] += 1
            @allocations[person_initiative][:people][t].push(p)
          end
        end
      end
    end

    # group together product initiatives
    @allocations_product_bucket = {}
    @allocations_product_bucket[:total] = 0
    @allocations_product_bucket[:product] = {}

    # create data for pie charts
    @allocations_product_pie = {}
    @allocations_supeng_pie = {}

    #set up hashes
    @initiatives.each do |i|
      if product_initiative?(i)
        @allocations_product_bucket[:product][:total] = 0
        @allocations_product_bucket[:product][:people] = {}
        @allocations_product_pie[i.name] = 0
        @teams.each do |t|
          @allocations_product_bucket[:product][:people][t] = []
        end
      else
        @allocations_product_bucket[i] = {}
        @allocations_product_bucket[i][:total] = 0
        @allocations_product_bucket[i][:people] = {}
        @teams.each do |t|
          @allocations_product_bucket[i][:people][t] = []
          @allocations_supeng_pie[t.name] = 0
        end
      end
    end

    # populate hashes with data
    @teams.each do |t|
      t.people.each do |p|
        if p.active_project_count != 0
          person_initiative = p.active_projects.first.initiative
          if !person_initiative.completed
            @allocations_product_bucket[:total] += 1
            if product_initiative?(person_initiative)
              @allocations_product_bucket[:product][:total] += 1
              @allocations_product_bucket[:product][:people][t].push(p)
              @allocations_product_pie[person_initiative.name] += 1
            else
              @allocations_product_bucket[person_initiative][:total] += 1
              @allocations_product_bucket[person_initiative][:people][t].push(p)
              @allocations_supeng_pie[t.name] += 1
            end
          end
        end
      end
    end

    @pie_all = allocations_pie_by_location("", @initiatives, @teams)
    @pie_sf = allocations_pie_by_location("SF", @initiatives, @teams)
    @pie_uk = allocations_pie_by_location("UK", @initiatives, @teams)
    @pie_red = allocations_pie_by_location("RED", @initiatives, @teams)
    @supeng_pie_all = supeng_pie_by_location("", @initiatives, @teams)
    @supeng_pie_sf = supeng_pie_by_location("SF", @initiatives, @teams)
    @supeng_pie_uk = supeng_pie_by_location("UK", @initiatives, @teams)
    @supeng_pie_red = supeng_pie_by_location("RED", @initiatives, @teams)

  end

  # GET /boards/1/changelog
  def changelog
    @versions = PaperTrail::Version.where(:board_id => @board.id).order(created_at: :desc)
  end

  # GET /boards/1/completed
  def completed
    @projects = [] # list of completed projects from non-standing initiatives, i.e. REAL projects
    @board.initiatives.where(:standing => false).each do |i|
      i.projects.where(:completed => true).where.not(:end_date => nil).each do |p|
        @projects.push(p)
    end
    end
  end

  # GET /boards/1/todo
  def todo
    @todo_projects = [] # list of projects missing experiment_key or tech_spec
    @board.initiatives.where(:standing => false).each do |i|
      i.projects.where(:experiment_key => [nil, ""], :tech_spec => [nil, ""]).where(:completed => false).each do |p|
        @todo_projects.push(p)
      end
    end
  end

  def send_reminders
    post_reminder_post_to_yammer(params[:data])

    flash[:notice] = "Reminders posted to Yammer"
    redirect_to board_todo_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      board = Board.find(params[:id] || params[:board_id])
      if board.network_id == current_user.network_id
        @board = board
      end
      @show_boards_nav = !@board.nil? && !@board.new_record?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:network_id, :name, :group_id_for_yammer_post)
    end

    def authenticate_user_from_token!
      user_email = params[:user_email].presence
      user       = user_email && User.find_by_email(user_email)

      # Notice how we use Devise.secure_compare to compare the token
      # in the database with the token given in the params, mitigating
      # timing attacks.
      if user && Devise.secure_compare(user.encrypted_password, params[:token])
        sign_in user, store: false
      end
    end

    def allocations_pie_by_location(location, initiatives, teams)
      @pie_data = {}

      initiatives.each do |i|
        if product_initiative?(i)
          @pie_data["Product"] = 0
        else
          @pie_data[i.name] = 0
        end
      end

      @teams.each do |t|
        t.people.each do |p|
          if p.active_project_count != 0
            person_initiative = p.active_projects.first.initiative
            if !person_initiative.completed
              if product_initiative?(person_initiative)
                @pie_data["Product"] += 1 if [p.location.name, ""].include?(location)
              else
                @pie_data[person_initiative.name] += 1 if [p.location.name, ""].include?(location)
              end
            end
          end
        end
      end
      return @pie_data
    end

    def supeng_pie_by_location(location, initiatives, teams)
      @pie_data = {}

      @teams.each do |t|
        @pie_data[t.name] = 0
        t.people.each do |p|
          if p.active_project_count != 0
            if p.active_projects.first.initiative.name == "Support Engineering"
              @pie_data[t.name] += 1 if [p.location.name, ""].include?(location)
            end
          end
        end
      end
      return @pie_data
    end

    def post_reminder_post_to_yammer(todo_project_ids)
      yamr = Yammer::Client.new(:access_token  => current_user.access_token)
      message = []
      todo_project_ids[0,3].each do |project_id|
        project = Project.find(project_id)
        if !project.initiative.standing?
          if project_group_id(project) # post to group if project has group link
            yamr.create_message("The project associated with this group has data missing on the big board (like experiment_key and tech spec link). Can you help us fill in the details? " + edit_board_project_url(@board, project), :group_id => project_group_id(project))
          else
            message << "\n\n" + project.name + ": " + edit_board_project_url(@board, project)
          end
        end
      end

      if @board.group_id_for_yammer_post and message.count != 0
        yamr.create_message("These projects have data missing on the big board (like experiment_key and tech spec link). Can you help us fill in the details? " + message.join, :group_id => @board.group_id_for_yammer_post)
      end
    end

    def project_group_id(project)
      return nil if project.yammer_group.nil? || project.yammer_group.match(/\&feedId=(.+)$/).nil?
      project.yammer_group.match(/\&feedId=(.+)$/)[1].to_i
    end
end
