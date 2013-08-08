class ColonisationreportsController < ApplicationController
  before_action :set_colonisationreport, only: [:show, :edit, :update, :destroy]

  # GET /colonisationreports
  # GET /colonisationreports.json
  def index
    @colonisationreports = Colonisationreport.all
  end

  # GET /colonisationreports/1
  # GET /colonisationreports/1.json
  def show
  end

  # GET /colonisationreports/new
  def new
    @colonisationreport = Colonisationreport.new
  end

  # GET /colonisationreports/1/edit
  def edit
  end

  # POST /colonisationreports
  # POST /colonisationreports.json
  def create
    @colonisationreport = Colonisationreport.new(colonisationreport_params)

    respond_to do |format|
      if @colonisationreport.save
        format.html { redirect_to @colonisationreport, notice: 'Colonisationreport was successfully created.' }
        format.json { render action: 'show', status: :created, location: @colonisationreport }
      else
        format.html { render action: 'new' }
        format.json { render json: @colonisationreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colonisationreports/1
  # PATCH/PUT /colonisationreports/1.json
  def update
    respond_to do |format|
      if @colonisationreport.update(colonisationreport_params)
        format.html { redirect_to @colonisationreport, notice: 'Colonisationreport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @colonisationreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colonisationreports/1
  # DELETE /colonisationreports/1.json
  def destroy
    @colonisationreport.destroy
    respond_to do |format|
      format.html { redirect_to colonisationreports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colonisationreport
      @colonisationreport = Colonisationreport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def colonisationreport_params
      params.require(:colonisationreport).permit(:mode)
    end
end
