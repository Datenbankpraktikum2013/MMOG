class SpyreportsController < ApplicationController
  before_action :set_spyreport, only: [:show, :edit, :update, :destroy]

  # GET /spyreports
  # GET /spyreports.json
  def index
    @spyreports = Spyreport.all
  end

  # GET /spyreports/1
  # GET /spyreports/1.json
  def show
  end

  # GET /spyreports/new
  def new
    @spyreport = Spyreport.new
  end

  # GET /spyreports/1/edit
  def edit
  end

  # POST /spyreports
  # POST /spyreports.json
  def create
    @spyreport = Spyreport.new(spyreport_params)

    respond_to do |format|
      if @spyreport.save
        format.html { redirect_to @spyreport, notice: 'Spyreport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @spyreport }
      else
        format.html { render action: 'new' }
        format.json { render json: @spyreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spyreports/1
  # PATCH/PUT /spyreports/1.json
  def update
    respond_to do |format|
      if @spyreport.update(spyreport_params)
        format.html { redirect_to @spyreport, notice: 'Spyreport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @spyreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spyreports/1
  # DELETE /spyreports/1.json
  def destroy
    @spyreport.destroy
    respond_to do |format|
      format.html { redirect_to spyreports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spyreport
      @spyreport = Spyreport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spyreport_params
      params.require(:spyreport).permit(:energy, :space_cash, :population, :ore, :crystall)
    end
end
