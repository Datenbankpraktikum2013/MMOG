class SunsystemsController < ApplicationController
  before_action :set_sunsystem, only: [:show, :edit, :update, :destroy]

  # GET /sunsystems
  # GET /sunsystems.json
  def index
    @sunsystems = Sunsystem.all
  end

  # GET /sunsystems/1
  # GET /sunsystems/1.json
  def show
    unless @sunsystem.is_visible_by?(current_user) then
      respond_to do |format|
        format.html { redirect_to galaxies_url }
        format.json { head :no_content }
      end
    end
  end

  # GET /sunsystems/new
  def new
    @sunsystem = Sunsystem.new
  end

  # GET /sunsystems/1/edit
  def edit
  end

  # POST /sunsystems
  # POST /sunsystems.json
  def create
    @sunsystem = Sunsystem.new(sunsystem_params)

    respond_to do |format|
      if @sunsystem.save
        format.html { redirect_to @sunsystem, notice: 'Sunsystem was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sunsystem }
      else
        format.html { render action: 'new' }
        format.json { render json: @sunsystem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sunsystems/1
  # PATCH/PUT /sunsystems/1.json
  def update
    respond_to do |format|
      if @sunsystem.update(sunsystem_params)
        format.html { redirect_to @sunsystem, notice: 'Sunsystem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sunsystem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sunsystems/1
  # DELETE /sunsystems/1.json
  def destroy
    @sunsystem.destroy
    respond_to do |format|
      format.html { redirect_to sunsystems_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sunsystem
      @sunsystem = Sunsystem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sunsystem_params
      params.require(:sunsystem).permit(:y, :name)
    end
end
