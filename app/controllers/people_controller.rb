class PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board
  before_action :set_teams, only: [:new, :edit, :create]
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @teams = Team.where(:board_id => @board.id)

    respond_to do |format|
      format.html { @people = Person.where(:board_id => @board.id).order(:team_id, :location_id, :name) }
      format.json { @people = Person.where(:board_id => @board.id).order(:name) }
    end
  end

  def autocomplete
    render json: Person.search(params[:query], where: {board_id: @board.id}, autocomplete: true, limit: 10)
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @project_memberships = ProjectMember.where(:person_id => @person.id).order(:start_date)
  end

  # GET /people/new
  def new
    @person = @board.people.build
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = @board.people.build(person_params)
    @person.network_id = current_user.network_id

    respond_to do |format|
      if @person.save
        format.html { redirect_to new_board_person_path(@board), notice: @person.name + ' was successfully added.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to board_person_path(@board, @person), notice: @person.name + ' was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    def set_board
      @board = Board.find(params[:board_id])
      @show_boards_nav = !@board.nil? && !@board.new_record?
    end

    def set_teams
      @teams = Team.where :board_id => @board.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:uid, :name, :image, :team_id, :location, :location_id, :project_id, :role_id, :board_id, :new_project_alert, :permalink)
    end
end
