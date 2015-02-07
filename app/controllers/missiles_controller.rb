class MissilesController < ApplicationController
  before_action :set_missile, only: [:show, :edit, :update, :destroy]
  before_action :set_fleet
  before_action :set_ship

  # GET /missiles
  # GET /missiles.json
  def index
    @missiles = Missile.all
  end

  # GET /missiles/1
  # GET /missiles/1.json
  def show
  end

  # GET /missiles/new
  def new
    @missile = Missile.new
  end

  # GET /missiles/1/edit
  def edit
  end

  # POST /missiles
  # POST /missiles.json
  def create
    @missile = @ship.missiles.new(missile_params)

    respond_to do |format|
      if @missile.save
        format.html { redirect_to fleet_path(@fleet), notice: 'Missile was successfully created.' }
        format.json { render :show, status: :created, location: @missile }
      else
        format.html { render :new }
        format.json { render json: @missile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /missiles/1
  # PATCH/PUT /missiles/1.json
  def update
    respond_to do |format|
      if @missile.update(missile_params)
        format.html { redirect_to @missile, notice: 'Missile was successfully updated.' }
        format.json { render :show, status: :ok, location: @missile }
      else
        format.html { render :edit }
        format.json { render json: @missile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missiles/1
  # DELETE /missiles/1.json
  def destroy
    @missile.destroy
    respond_to do |format|
      format.html { redirect_to fleet_path(@fleet), notice: 'Missile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_missile
      @missile = Missile.find(params[:id])
    end
  
    def set_ship
      @ship = Ship.find(params[:ship_id])
    end

    def set_fleet
      @fleet = Fleet.find(params[:fleet_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def missile_params
      params.require(:missile).permit(:power, :dice)
    end
end
