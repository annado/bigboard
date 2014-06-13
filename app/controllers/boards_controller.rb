class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :changelog, :allocation, :update, :destroy]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.where network_id: current_user.network_id
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

  # GET /boards/1/allocation
  def allocation
    @teams = @board.teams.where(:single_project => true).order(:name)
    @allocations = {
      :total => 0,
      :product => {
        :total => 0,
        :people => {}
      },
      :internal => {
        :total => 0,
        :people => {},
        :support => {
          :total => 0
        },
        :projects => {
          :total => 0
        }
      },
      :unassigned => []
    }
    @teams.each do |t|
      @allocations[:product][:people][t] = []
      @allocations[:internal][:people][t] = []
      @allocations[:internal][:projects][t] = []
      @allocations[:internal][:support][t] = []
      t.people.each do |p|
        @allocations[:total] += 1
        if p.allocated_to('Product')
          @allocations[:product][:total] += 1
          @allocations[:product][:people][t].push(p)
        elsif p.allocated_to('Internal Projects')
          @allocations[:internal][:total] += 1
          @allocations[:internal][:people][t].push(p)
          if p.allocated_to_internal_initiative
            @allocations[:internal][:projects][t].push(p)
            @allocations[:internal][:projects][:total] += 1
          else
            @allocations[:internal][:support][t].push(p)
            @allocations[:internal][:support][:total] += 1
          end
        else
          @allocations[:unassigned].push(p)
        end
      end
    end
  end

  # GET /boards/1/changelog
  def changelog
    @versions = PaperTrail::Version.where(:board_id => @board.id).order(created_at: :desc)
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
      params.require(:board).permit(:network_id, :name)
    end
end
