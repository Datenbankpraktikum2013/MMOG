class ShipBuildingQueuesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_ship_building_queue, only: [:show, :edit, :update, :destroy, :destroy_queue]
  # GET /ship_building_queues
  # GET /ship_building_queues.json
  def index
    @ship_building_queues = ShipBuildingQueue.all
  end

  # GET /ship_building_queues/1
  # GET /ship_building_queues/1.json
  def show
  end

  # GET /ship_building_queues/new
  def new
    @ship_building_queue = ShipBuildingQueue.new
  end

  # GET /ship_building_queues/1/edit
  def edit
  end

  # POST /ship_building_queues
  # POST /ship_building_queues.json
  def create
    @ship_building_queue = ShipBuildingQueue.new(ship_building_queue_params)

    respond_to do |format|
      if @ship_building_queue.save
        format.html { redirect_to @ship_building_queue, notice: 'Ship building queue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ship_building_queue }
      else
        format.html { render action: 'new' }
        format.json { render json: @ship_building_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ship_building_queues/1
  # PATCH/PUT /ship_building_queues/1.json
  def update
    respond_to do |format|
      if @ship_building_queue.update(ship_building_queue_params)
        format.html { redirect_to @ship_building_queue, notice: 'Ship building queue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ship_building_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ship_building_queues/1
  # DELETE /ship_building_queues/1.json
  def destroy
    if @ship_building_queue.planet.user == current_user
      @ship_building_queue.destroy
      respond_to do |format|
        format.html { redirect_to ship_building_queues_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to ship_building_queues_url }
        format.json { head :no_content }
      end
    end
  end

  def destroy_queue
    if(current_user.id==@ship_building_queue.planet.user_id)
      @ship_building_queue.remove_queue
      respond_to do |format|
        format.html { redirect_to starport_url  }
        format.json { head :no_content }

      end
    else
        respond_to do |format|
        format.html { redirect_to starport_url  }
        format.json { head :no_content }

      end
    end
  end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship_building_queue
      @ship_building_queue = ShipBuildingQueue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ship_building_queue_params
      params.require(:ship_building_queue).permit(:planet_id, :end_time, :ship_id)
    end


end
