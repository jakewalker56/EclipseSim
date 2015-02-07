class ShipsController < ApplicationController
  before_action :set_ship, only: [:show, :edit, :update, :destroy]
  before_action :double_set_ship, only: [:duplicate]
  before_action :set_fleet
  # GET /ships
  # GET /ships.json
  def index
    @ships = Ship.all
  end

  def duplicate
    puts "duplication"
    dupe = @ship.dup
    dupe.save
    puts dupe.inspect
    @ship.cannons.each do |cannon|
      dupe_cannon = cannon.dup
      dupe_cannon.ship_id = dupe.id
      dupe_cannon.save
    end

    @ship.missiles.each do |missile|
      dupe_missile = missile.dup
      dupe_missile.ship_id = dupe.id
      dupe_missile.save
    end

    respond_to do |format|
        format.html { redirect_to fleet_path(@fleet), notice: 'Ship was successfully created.' }
        format.json { render :show, status: :created, location: dupe }
    end
  end

  # GET /ships/1
  # GET /ships/1.json
  def show
  end

  # GET /ships/new
  def new
    @ship = Ship.new
  end

  # GET /ships/1/edit
  def edit
  end

  # POST /ships
  # POST /ships.json
  def create
    @ship = @fleet.ships.new(ship_params)

    respond_to do |format|
      if @ship.save
        format.html { redirect_to fleet_path(@fleet), notice: 'Ship was successfully created.' }
        format.json { render :show, status: :created, location: @ship }
      else
        format.html { render :new }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ships/1
  # PATCH/PUT /ships/1.json
  def update
    respond_to do |format|
      if @ship.update(ship_params)
        format.html { redirect_to fleet_path(@fleet), notice: 'Ship was successfully updated.' }
        format.json { render :show, status: :ok, location: @ship }
      else
        format.html { render :edit }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ships/1
  # DELETE /ships/1.json
  def destroy
    @ship.destroy
    respond_to do |format|
      format.html { redirect_to fleet_path(@fleet), notice: 'Ship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship
      @ship = Ship.find(params[:id])
    end
    def double_set_ship
      @ship = Ship.find(params[:ship_id])
    end
    def set_fleet
      @fleet = Fleet.find(params[:fleet_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def ship_params
      params.require(:ship).permit(:name, :targetting, :initiative, :shield, :hull)
    end
end
