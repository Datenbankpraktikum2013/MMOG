class TradereportsController < ApplicationController
  before_action :set_tradereport, only: [:show, :edit, :update, :destroy]

  # GET /tradereports
  # GET /tradereports.json
  def index
    @tradereports = Tradereport.all
  end

  # GET /tradereports/1
  # GET /tradereports/1.json
  def show
  end

  # GET /tradereports/new
  def new
    @tradereport = Tradereport.new
  end

  # GET /tradereports/1/edit
  def edit
  end

  # POST /tradereports
  # POST /tradereports.json
  def create
    @tradereport = Tradereport.new(tradereport_params)

    respond_to do |format|
      if @tradereport.save
        format.html { redirect_to @tradereport, notice: 'Tradereport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tradereport }
      else
        format.html { render action: 'new' }
        format.json { render json: @tradereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tradereports/1
  # PATCH/PUT /tradereports/1.json
  def update
    respond_to do |format|
      if @tradereport.update(tradereport_params)
        format.html { redirect_to @tradereport, notice: 'Tradereport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tradereport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tradereports/1
  # DELETE /tradereports/1.json
  def destroy
    @tradereport.destroy
    respond_to do |format|
      format.html { redirect_to tradereports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tradereport
      @tradereport = Tradereport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tradereport_params
      params.require(:tradereport).permit(:ore, :crystal, :space_cash)
    end
end
