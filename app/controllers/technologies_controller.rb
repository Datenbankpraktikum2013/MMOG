class TechnologiesController < ApplicationController
  before_action :set_technology, only: [:show, :edit, :update, :destroy, :upgrade,:show_index]
  before_filter :authenticate_user!

  # GET /technologies
  # GET /technologies.json
  def index
    @technologies = Technology.all

  end

  # GET /technologies/1
  # GET /technologies/1.json
  def show
  end

  # GET /technologies/new
  def new
    @technology = Technology.new
  end

  # GET /technologies/1/edit
  def edit
  end

  # POST /technologies
  # POST /technologies.json
  def create
    @technology = Technology.new(technology_params)

    respond_to do |format|
      if @technology.save
        format.html { redirect_to @technology, notice: 'Technology was successfully created.' }
        format.json { render action: 'show', status: :created, location: @technology }
      else
        format.html { render action: 'new' }
        format.json { render json: @technology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /technologies/1
  # PATCH/PUT /technologies/1.json
  def update
    respond_to do |format|
      if @technology.update(technology_params)
        format.html { redirect_to @technology, notice: 'Technology was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @technology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /technologies/1
  # DELETE /technologies/1.json
  def destroy
    @technology.destroy
    respond_to do |format|
      format.html { redirect_to technologies_url }
      format.json { head :no_content }
    end
  end

  def upgrade
    @technology.upgrade_technology(params["uid"])
    respond_to do |format|
      format.html { redirect_to action: 'index', notice: 'Forschung erfolgreich aufgewertet.'}
      format.json {head :no_content}
    end
  end

  def show_index
    respond_to do |format|
      format.html { redirect_to action: 'index'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_technology
      @technology = Technology.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def technology_params
      params.require(:technology).permit(:name, :factor)
    end
end
