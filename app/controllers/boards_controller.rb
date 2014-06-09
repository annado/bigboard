class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :changelog, :update, :destroy]

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

  # GET /boards/1/changelog
  def changelog
    @versions = PaperTrail::Version.where(:board_id => @board.id).order(created_at: :desc)
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
