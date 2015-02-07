class CannonsController < ApplicationController
  before_action :set_cannon, only: [:show, :edit, :update, :destroy]
  before_action :set_fleet
  before_action :set_ship
  # GET /cannons
  # GET /cannons.json
  def index
    @cannons = Cannon.all
  end

  # GET /cannons/1
  # GET /cannons/1.json
  def show
  end

  # GET /cannons/new
  def new
    @cannon = Cannon.new
  end

  # GET /cannons/1/edit
  def edit
  end

  # POST /cannons
  # POST /cannons.json
  def create
    @cannon = @ship.cannons.new(cannon_params)

    respond_to do |format|
      if @cannon.save
        format.html { redirect_to fleet_path(@fleet), notice: 'Cannon was successfully created.' }
        format.json { render :show, status: :created, location: @cannon }
      else
        format.html { render :new }
        format.json { render json: @cannon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cannons/1
  # PATCH/PUT /cannons/1.json
  def update
    respond_to do |format|
      if @cannon.update(cannon_params)
        format.html { redirect_to @cannon, notice: 'Cannon was successfully updated.' }
        format.json { render :show, status: :ok, location: @cannon }
      else
        format.html { render :edit }
        format.json { render json: @cannon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cannons/1
  # DELETE /cannons/1.json
  def destroy
    @cannon.destroy
    respond_to do |format|
      format.html { redirect_to fleet_path(@fleet), notice: 'Cannon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cannon
      @cannon = Cannon.find(params[:id])
    end

    def set_ship
      @ship = Ship.find(params[:ship_id])
    end

    def set_fleet
      @fleet = Fleet.find(params[:fleet_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def cannon_params
      params.require(:cannon).permit(:dice, :power)
    end
end
