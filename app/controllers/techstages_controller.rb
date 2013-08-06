class TechstagesController < ApplicationController
  before_action :set_techstage, only: [:show, :edit, :update, :destroy]

  # GET /techstages
  # GET /techstages.json
  def index
    @techstages = Techstage.all
  end

  # GET /techstages/1
  # GET /techstages/1.json
  def show
  end

  # GET /techstages/new
  def new
    @techstage = Techstage.new
  end

  # GET /techstages/1/edit
  def edit
  end

  # POST /techstages
  # POST /techstages.json
  def create
    @techstage = Techstage.new(techstage_params)

    respond_to do |format|
      if @techstage.save
        format.html { redirect_to @techstage, notice: 'Techstage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @techstage }
      else
        format.html { render action: 'new' }
        format.json { render json: @techstage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /techstages/1
  # PATCH/PUT /techstages/1.json
  def update
    respond_to do |format|
      if @techstage.update(techstage_params)
        format.html { redirect_to @techstage, notice: 'Techstage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @techstage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /techstages/1
  # DELETE /techstages/1.json
  def destroy
    @techstage.destroy
    respond_to do |format|
      format.html { redirect_to techstages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_techstage
      @techstage = Techstage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def techstage_params
      params.require(:techstage).permit(:spyreport_id, :technology_id, :level)
    end
end
