class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all.joins(:receiving_reports).select('reports.*, receiving_reports.read AS read').where(receiving_reports: {user_id: current_user}).order('receiving_reports.read', fightdate: :desc)
      respond_to do |format|
        format.html
        format.js
      end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    if @report.receiver_ids.include? current_user.id
      ReceivingReport.where(user_id: current_user.id, report_id: @report.id).first.update_attribute :read, true
      respond_to do |format|
        format.html { render "show_#{@report.reportable_type}" }
        format.js
      end
    else
      redirect_to reports_path, notice: "Der angeforderte Bericht existiert nicht."
    end
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    # @report = Report.new(report_params)

    # respond_to do |format|
    #   if @report.save
    #     format.html { redirect_to @report, notice: 'Report was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @report }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @report.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    # respond_to do |format|
    #   if @report.update(report_params)
    #     format.html { redirect_to @report, notice: 'Report was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @report.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy_receiver(current_user.id)
    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:reportable_id, :defender_planet_id, :attacker_planet_id, :fightdate, :defender_id, :attacker_id)
    end
end
