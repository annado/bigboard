class InitiativesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board
  before_action :set_initiative, only: [:show, :edit, :update, :destroy]
  before_action :set_select_fields, only: [:new, :edit, :update]

  # GET /initiatives
  # GET /initiatives.json
  def index
    @initiatives = Initiative.where(:board_id => @board.id)
  end

  # GET /initiatives/1
  # GET /initiatives/1.json
  def show
  end

  # GET /initiatives/new
  def new
    @initiative = @board.initiatives.build
  end

  # GET /initiatives/1/edit
  def edit
  end

  # POST /initiatives
  # POST /initiatives.json
  def create
    @initiative = @board.initiatives.build(initiative_params)

    respond_to do |format|
      if @initiative.save
        format.html { redirect_to edit_board_initiative_path(@board, @initiative), notice: 'Initiative was successfully created.' }
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
        format.html { redirect_to board_initiative_url(@board, @initiative), notice: 'Initiative was successfully updated.' }
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
      format.html { redirect_to edit_board_initiative_path(@board) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_initiative
      @initiative = Initiative.find(params[:id])
    end

    def set_board
      @board = Board.find(params[:board_id])
      @show_boards_nav = !@board.nil? && !@board.new_record?
    end

    def set_select_fields
      @people = Person.where(board_id: @board.id).order(:name)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def initiative_params
      if (params[:ended]) 
        params[:end_date] = today
      end
      params.require(:initiative).permit(:name, :start_date, :end_date, :manager_id, :analyst_id, :owner_id, :security_id, :board_id, :completed, :standing)
    end
end
