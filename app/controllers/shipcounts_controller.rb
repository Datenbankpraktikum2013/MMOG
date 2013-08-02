class ShipcountsController < ApplicationController
  before_action :set_shipcount, only: [:show, :edit, :update, :destroy]

  # GET /shipcounts
  # GET /shipcounts.json
  def index
    @shipcounts = Shipcount.all
  end

  # GET /shipcounts/1
  # GET /shipcounts/1.json
  def show
  end

  # GET /shipcounts/new
  def new
    @shipcount = Shipcount.new
  end

  # GET /shipcounts/1/edit
  def edit
  end

  # POST /shipcounts
  # POST /shipcounts.json
  def create
    @shipcount = Shipcount.new(shipcount_params)

    respond_to do |format|
      if @shipcount.save
        format.html { redirect_to @shipcount, notice: 'Shipcount was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shipcount }
      else
        format.html { render action: 'new' }
        format.json { render json: @shipcount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipcounts/1
  # PATCH/PUT /shipcounts/1.json
  def update
    respond_to do |format|
      if @shipcount.update(shipcount_params)
        format.html { redirect_to @shipcount, notice: 'Shipcount was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shipcount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipcounts/1
  # DELETE /shipcounts/1.json
  def destroy
    @shipcount.destroy
    respond_to do |format|
      format.html { redirect_to shipcounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipcount
      @shipcount = Shipcount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipcount_params
      params.require(:shipcount).permit(:battlereport_id, :ship_id, :amount, :shipowner_time_type)
    end
end
