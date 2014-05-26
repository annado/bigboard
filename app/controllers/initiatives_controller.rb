class InitiativesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_initiative, only: [:show, :edit, :update, :destroy]
  before_action :set_select_fields, only: [:new, :edit, :update]

  # GET /initiatives
  # GET /initiatives.json
  def index
    @initiatives = Initiative.all
  end

  # GET /initiatives/1
  # GET /initiatives/1.json
  def show
  end

  # GET /initiatives/new
  def new
    @initiative = Initiative.new
  end

  # GET /initiatives/1/edit
  def edit
  end

  # POST /initiatives
  # POST /initiatives.json
  def create
    @initiative = Initiative.new(initiative_params)

    respond_to do |format|
      if @initiative.save
        format.html { redirect_to @initiative, notice: 'Initiative was successfully created.' }
        format.json { render :show, status: :created, location: @initiative }
      else
        format.html { render :new }
        format.json { render json: @initiative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /initiatives/1
  # PATCH/PUT /initiatives/1.json
  def update
    respond_to do |format|
      if @initiative.update(initiative_params)
        format.html { redirect_to @initiative, notice: 'Initiative was successfully updated.' }
        format.json { render :show, status: :ok, location: @initiative }
      else
        format.html { render :edit }
        format.json { render json: @initiative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /initiatives/1
  # DELETE /initiatives/1.json
  def destroy
    @initiative.destroy
    respond_to do |format|
      format.html { redirect_to initiatives_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_initiative
      @initiative = Initiative.find(params[:id])
    end

    def set_select_fields
      manager_id = Team.find_by name: 'Manager'
      @managers = Person.where team_id: manager_id

      analyst_team_id = Team.find_by name: 'Analytics'
      @analysts = Person.where team_id: analyst_team_id || []

      product_team_id = Team.find_by name: 'PM'
      @pms = Person.where team_id: product_team_id || []

      @boards = Board.where network_id: current_user.network_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def initiative_params
      if (params[:ended]) 
        params[:end_date] = today
      end
      params.require(:initiative).permit(:name, :start_date, :end_date, :manager_id, :analyst_id, :owner_id, :board_id)
    end
end
