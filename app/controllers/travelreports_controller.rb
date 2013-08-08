class TravelreportsController < ApplicationController
  before_action :set_travelreport, only: [:show, :edit, :update, :destroy]

  # GET /travelreports
  # GET /travelreports.json
  def index
    @travelreports = Travelreport.all
  end

  # GET /travelreports/1
  # GET /travelreports/1.json
  def show
  end

  # GET /travelreports/new
  def new
    @travelreport = Travelreport.new
  end

  # GET /travelreports/1/edit
  def edit
  end

  # POST /travelreports
  # POST /travelreports.json
  def create
    @travelreport = Travelreport.new(travelreport_params)

    respond_to do |format|
      if @travelreport.save
        format.html { redirect_to @travelreport, notice: 'Travelreport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @travelreport }
      else
        format.html { render action: 'new' }
        format.json { render json: @travelreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travelreports/1
  # PATCH/PUT /travelreports/1.json
  def update
    respond_to do |format|
      if @travelreport.update(travelreport_params)
        format.html { redirect_to @travelreport, notice: 'Travelreport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @travelreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travelreports/1
  # DELETE /travelreports/1.json
  def destroy
    @travelreport.destroy
    respond_to do |format|
      format.html { redirect_to travelreports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travelreport
      @travelreport = Travelreport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travelreport_params
      params.require(:travelreport).permit(:mode)
    end
end
