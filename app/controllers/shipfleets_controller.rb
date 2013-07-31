class ShipfleetsController < ApplicationController
  before_action :set_shipfleet, only: [:show, :edit, :update, :destroy]

  # GET /shipfleets
  # GET /shipfleets.json
  def index
    @shipfleets = Shipfleet.all
  end

  # GET /shipfleets/1
  # GET /shipfleets/1.json
  def show
  end

  # GET /shipfleets/new
  def new
    @shipfleet = Shipfleet.new
  end

  # GET /shipfleets/1/edit
  def edit
  end

  # POST /shipfleets
  # POST /shipfleets.json
  def create
    @shipfleet = Shipfleet.new(shipfleet_params)

    respond_to do |format|
      if @shipfleet.save
        format.html { redirect_to @shipfleet, notice: 'Shipfleet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shipfleet }
      else
        format.html { render action: 'new' }
        format.json { render json: @shipfleet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipfleets/1
  # PATCH/PUT /shipfleets/1.json
  def update
    respond_to do |format|
      if @shipfleet.update(shipfleet_params)
        format.html { redirect_to @shipfleet, notice: 'Shipfleet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shipfleet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipfleets/1
  # DELETE /shipfleets/1.json
  def destroy
    @shipfleet.destroy
    respond_to do |format|
      format.html { redirect_to shipfleets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipfleet
      @shipfleet = Shipfleet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipfleet_params
      params.require(:shipfleet).permit(:ship_id, :fleet_id, :amount)
    end
end
