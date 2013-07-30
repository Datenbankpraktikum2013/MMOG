class BuildingtypesController < ApplicationController
  before_action :set_buildingtype, only: [:show, :edit, :update, :destroy]

  # GET /buildingtypes
  # GET /buildingtypes.json
  def index
    @buildingtypes = Buildingtype.all
  end

  # GET /buildingtypes/1
  # GET /buildingtypes/1.json
  def show
  end

  # GET /buildingtypes/new
  def new
    @buildingtype = Buildingtype.new
  end

  # GET /buildingtypes/1/edit
  def edit
  end

  # POST /buildingtypes
  # POST /buildingtypes.json
  def create
    @buildingtype = Buildingtype.new(buildingtype_params)

    respond_to do |format|
      if @buildingtype.save
        format.html { redirect_to @buildingtype, notice: 'Buildingtype was successfully created.' }
        format.json { render action: 'show', status: :created, location: @buildingtype }
      else
        format.html { render action: 'new' }
        format.json { render json: @buildingtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buildingtypes/1
  # PATCH/PUT /buildingtypes/1.json
  def update
    respond_to do |format|
      if @buildingtype.update(buildingtype_params)
        format.html { redirect_to @buildingtype, notice: 'Buildingtype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @buildingtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buildingtypes/1
  # DELETE /buildingtypes/1.json
  def destroy
    @buildingtype.destroy
    respond_to do |format|
      format.html { redirect_to buildingtypes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buildingtype
      @buildingtype = Buildingtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buildingtype_params
      params.require(:buildingtype).permit(:name, :stufe, :produktion, :energieverbrauch)
    end
end
